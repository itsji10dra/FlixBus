//
//  ViewController.swift
//  FlixBus
//
//  Created by Jitendra on 28/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class StationsListVC: UIViewController {

    // MARK: - IBOutlets
    
    
    // MARK: - Data
    
    private let stations: [Station] = {
        return [Station(1, name: "Berlin ZOB"),
                Station(10, name: "Munich ZOB")]
    }()
    
    // MARK: - View Hierarchy
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    

}

