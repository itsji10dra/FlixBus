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
    
    // MARK: - Data
    
    internal var station: Station?
    
    // MARK: - Rx
    
    private var results = PublishSubject<[JourneyTimeTableInfo]>()

    let disposeBag = DisposeBag()
    
    // MARK: - View Hierarchy

    override func viewDidLoad() {
        super.viewDidLoad()

        title = station?.name
        
        tableViewModel()
    
        loadTimeTable()
    }
    
    private func loadTimeTable() {
        
        guard let stationId = station?.id else { return }
        
        let urlString = Configuration.url + Configuration.getFilledResourcePath(.timeTable, parameters: [String(stationId)])
        let headers: [String:String] = [Header.apiAuthentication.rawValue:Configuration.authenticationToken]

        LoadingIndicator.startAnimating()
        
        RxAlamofire.requestJSON(.get, urlString, headers: headers)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (_, json) in
                let data = TimeTableInfo.parse(json)
//                print("Data:", data)

                var results: [JourneyTimeTableInfo] = []
                data.forEach {
                    let result = JourneyTimeTableInfo(journeyType: $0.key, timeTableData: $0.value)
                    results.append(result)
                }
                
                self.results.onNext(results)
                
            }, onError: { (error) in
                print("Error:", error)
            }, onCompleted: {
                LoadingIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Rx Model

    private func tableViewDataSource() -> RxTableViewSectionedAnimatedDataSource<JourneyTimeTableInfo> {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .fade,
                                                            reloadAnimation: .automatic,
                                                            deleteAnimation: .fade)
        
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
        
        self.results.bind(to: detailsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        detailsTableView.rx
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
