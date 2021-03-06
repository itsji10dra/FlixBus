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
    
    var timeTableData: [RideInfo]
    
    init(journeyType: JourneyType, timeTableData: [RideInfo]) {
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
    typealias Item = RideInfo
    var items: [RideInfo] {
        return timeTableData
    }
    
    init(original: JourneyTimeTableInfo, items: [RideInfo]) {
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
    
    private lazy var journeyInfoData: [JourneyType: [RideInfo]] = [:]
    
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
        
        let urlString = Configuration.getURL(forResource: .timeTable, parameters: [String(stationId)])
        let headers = Configuration.getHeaders()

        LoadingIndicator.startAnimating()
        
        RxAlamofire.requestData(.get, urlString, headers: headers)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_, data) in
                let data = RideInfo.parse(data)
                self?.journeyInfoData = data
                self?.updateDataSourceForDefaultPreference()
            }, onError: { [weak self] error in
                LoadingIndicator.stopAnimating()
                self?.showNetworkErrorAlert(with: error.localizedDescription)
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
    
    private func showNetworkErrorAlert(with message: String) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] action in
            self?.loadTimeTable()
        }
        alertController.addAction(retryAction)
        
        let goBackAction = UIAlertAction(title: "Go Back", style: .cancel) { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(goBackAction)

        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Action
    
    @IBAction func preferenceAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Change",
                                                message: "Your display preference",
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
            .modelSelected(RideInfo.self)
            .subscribe(onNext:  { [weak self] timeTableInfo in
                self?.showRouteInfo(with: timeTableInfo)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Navigation
    
    private func showRouteInfo(with timeTable: RideInfo) {
        
        guard let routeInfoVC = Navigation.getViewController(type: RouteInfoVC.self, identifer: "RouteInfo") else { return }
        
        routeInfoVC.timeTableInfo = timeTable

        navigationController?.pushViewController(routeInfoVC, animated: true)
    }
}
