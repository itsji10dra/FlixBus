//
//  ViewController.swift
//  FlixBus
//
//  Created by Jitendra on 28/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StationsListVC: UIViewController, UITableViewDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet weak private var stationTableView: UITableView!

    // MARK: - Data
    
    private let stations: [Station] = {         //Hard-coding for Assignment
        return [Station(1, name: "Berlin ZOB"),
                Station(10, name: "Munich ZOB")]
    }()
    
    // MARK: - Rx
    
    let disposeBag = DisposeBag()

    // MARK: - View Hierarchy
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let observableStations: Observable<[Station]> = Observable.just(stations)
    
        observableStations.bind(to: stationTableView.rx.items(cellIdentifier: "StationCell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = element.name
        }
        .disposed(by: disposeBag)
        
        stationTableView.rx
            .modelSelected(Station.self)
            .subscribe(onNext:  { [weak self] station in
                self?.showTimeTableInfo(for: station)
            })
            .disposed(by: disposeBag)
        
        stationTableView.rx
            .itemSelected
            .subscribe(onNext:  { [weak self] indexPath in
                self?.stationTableView.reloadRows(at: [indexPath], with: .none)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Navigation
    
    private func showTimeTableInfo(for station: Station) {
        
        guard let timeTableVC = Navigation.getViewController(type: TimeTableListVC.self, identifer: "TimeTableList") else { return }
        
        timeTableVC.station = stations.first!
        
        navigationController?.pushViewController(timeTableVC, animated: true)
        
        print(timeTableVC, station)
    }

}

