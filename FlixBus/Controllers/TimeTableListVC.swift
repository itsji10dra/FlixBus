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

class TimeTableListVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak private var detailsTableView: UITableView!
    
    // MARK: - Data
    
    var station: Station?
    
    // MARK: - Rx
    
    let disposeBag = DisposeBag()
    
    // MARK: - View Hierarchy

    override func viewDidLoad() {
        super.viewDidLoad()

        title = station?.name
        
        guard let stationId = station?.id else { return }
        
        let urlString = Configuration.url + Configuration.getFilledResourcePath(.timeTable, parameters: [String(stationId)])
        let headers: [String:String] = [Header.apiAuthentication.rawValue:Configuration.authenticationToken]
        
        RxAlamofire.requestJSON(.get, urlString, headers: headers)
            .subscribe(onNext: { [weak self] (response, json) in
                print("JSON:", json)
            }, onError: { [weak self] (error) in
                print("Error:", error)
            })
            .disposed(by: disposeBag)
    }
}
