//
//  TimeTableListVC.swift
//  FlixBus
//
//  Created by Jitendra on 28/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import RxDataSources

//-------------------------------------------------------------------------------------------------------------
// MARK: - DataSource

private struct JourneyTimeTableInfo {
    
    var journeyType: JourneyType
    
    var timeTableData: [TimeTableInfo]
    
    init(journeyType: JourneyType, timeTableData: [TimeTableInfo]) {
        self.journeyType = journeyType
        self.timeTableData = timeTableData
    }
}

extension JourneyTimeTableInfo: AnimatableSectionModelType {
    
    typealias Identity = String
    var identity: String {
        return journeyType.rawValue
    }
    
    // Items declare data for section rows
    typealias Item = TimeTableInfo
    var items: [TimeTableInfo] {
        return timeTableData
    }
    
    init(original: JourneyTimeTableInfo, items: [TimeTableInfo]) {
        self = original
        self.timeTableData = items
    }
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - ViewController Class

class TimeTableListVC: UIViewController, UITableViewDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet weak private var detailsTableView: UITableView!
    
    @IBOutlet weak private var preferenceBarButton: UIBarButtonItem!
    
    // MARK: - Data
        
    internal var station: Station?
        
    // MARK: - Rx
    
    private lazy var journeyInfoData: [JourneyType: [TimeTableInfo]] = [:]
    
    private var dataSource = PublishSubject<[JourneyTimeTableInfo]>()

    private let disposeBag = DisposeBag()
    
    // MARK: - View Hierarchy

    override func viewDidLoad() {
        super.viewDidLoad()

        title = station?.name
        
        tableViewModel()
    
        loadTimeTable()
    }
    
    // MARK: - Private Methods

    private func loadTimeTable() {
        
        guard let stationId = station?.id else { return }
        
        let urlString = Configuration.url + Configuration.getFilledResourcePath(.timeTable, parameters: [String(stationId)])
        let headers: [String:String] = [Header.apiAuthentication.rawValue:Configuration.authenticationToken]

        LoadingIndicator.startAnimating()
        
        RxAlamofire.requestJSON(.get, urlString, headers: headers)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_, json) in
                let data = TimeTableInfo.parse(json)
                self?.journeyInfoData = data
                self?.updateDataSourceForDefaultPreference()
            }, onError: { (error) in
                print("Error:", error)
            }, onCompleted: {
                LoadingIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
    }

    private func updateDataSourceForDefaultPreference() {
        
        var results: [JourneyTimeTableInfo] = []
        
        journeyInfoData.forEach {
            let result = JourneyTimeTableInfo(journeyType: $0.key, timeTableData: $0.value)
            results.append(result)
        }
        
        let priorJourneyType = Preference.defaultPreference.linkedJourneyType
        
        if let priorInfoIndex = results.index(where: { journeyTimeTableInfo -> Bool in
            return journeyTimeTableInfo.journeyType == priorJourneyType
        }) {
            let priorInfoObject = results.remove(at: priorInfoIndex)
            results.insert(priorInfoObject, at: 0)
        }
    
        self.dataSource.onNext(results)
    }
    
    // MARK: - Action
    
    @IBAction func preferenceAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Display preference.",
                                                message: nil,
                                                preferredStyle: .alert)
        
        let currentPrefJourneyType = Preference.defaultPreference.linkedJourneyType
        
        var options = Preference.getPreferenceList()
        
        if let indexCurrentPref = options.index(where: { $0.linkedJourneyType == currentPrefJourneyType }) {
            options.remove(at: indexCurrentPref)
        }
        
        options.forEach { option in
            let alertAction = UIAlertAction(title: option.stringValue,
                                            style: .default,
                                            handler: { [weak self] action in
                Preference.defaultPreference = option
                self?.updateDataSourceForDefaultPreference()
            })
            alertController.addAction(alertAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                        style: .cancel,
                                        handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Rx Model

    private func tableViewDataSource() -> RxTableViewSectionedAnimatedDataSource<JourneyTimeTableInfo> {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                            reloadAnimation: .none,
                                                            deleteAnimation: .automatic)
        
        return RxTableViewSectionedAnimatedDataSource<JourneyTimeTableInfo>(
                animationConfiguration: animationConfiguration,
                configureCell: { (_, tableView, _, item) in
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableCell") as? TimeTableCell else {
                    return UITableViewCell(style: .default, reuseIdentifier: "default")
                }
                
                cell.configure(data: item)
                return cell
            },
            titleForHeaderInSection: { (datasource, section) in
                return datasource[section].journeyType.rawValue
            })
    }

    private func tableViewModel() {
        
        let dataSource = tableViewDataSource()
        
        self.dataSource
            .bind(to: detailsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.dataSource                                //In-case of partial updates
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.detailsTableView.reloadData()
            }
            .disposed(by: disposeBag)

        self.detailsTableView.rx
            .modelSelected(TimeTableInfo.self)
            .subscribe(onNext:  { [weak self] timeTableInfo in
                self?.showRouteInfo(with: timeTableInfo)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Navigation
    
    private func showRouteInfo(with timeTable: TimeTableInfo) {
        
        guard let routeInfoVC = Navigation.getViewController(type: RouteInfoVC.self, identifer: "RouteInfo") else { return }
        
        routeInfoVC.timeTableInfo = timeTable

        navigationController?.pushViewController(routeInfoVC, animated: true)
    }
}
