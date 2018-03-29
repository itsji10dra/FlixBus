//
//  RouteInfoVC.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class RouteInfoVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak private var routeStackView: UIStackView!

    // MARK: - Data
    
    internal var routes: [RouteInfo]?
    
    // MARK: - View Hierarchy

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Routes"

        loadRoutes()
    }

    // MARK: - Private Methods

    private func loadRoutes() {
        
        guard let routes = routes else { return }

        routes.forEach { route in
            let view = RouteInfoView()
            view.loadData(from: route)
            routeStackView.addArrangedSubview(view)
        }
    }
}