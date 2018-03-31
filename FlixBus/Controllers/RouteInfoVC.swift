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
    
    internal var timeTableInfo: TimeTableInfo?
    
    // MARK: - View Hierarchy

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle()
        loadRoutes()
    }

    // MARK: - Private Methods

    private func setTitle() {
        
        let defaultTitle = "Routes"
        
        guard let date = timeTableInfo?.dateTimeInfo else {
            self.title = defaultTitle
            return
        }

        let title = defaultTitle + " @ " + (date.getLocalTime(.HH_colon_mm) ?? "")
        let subtitle = date.getLocalTime(.dd_space_MMMM_comma_space_YYYY) ?? ""
        
        let titleSize: CGFloat = 18
        let subtitleSize: CGFloat = 16

        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        
        if #available(iOS 11, *) {
            //iOS 11 is smart. Nothing to do.
        } else {
            label.frame = .init(x: 0, y: 0, width: 150, height: 64)     //Requires for iOS 10 and lower.
        }
        
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: title, attributes: [.font : UIFont.boldSystemFont(ofSize: titleSize)]))
        text.append(NSAttributedString(string: "\n\(subtitle)", attributes: [.font : UIFont.systemFont(ofSize: subtitleSize)]))
        label.attributedText = text
        
        navigationItem.titleView = label
    }
    
    private func loadRoutes() {
        
        guard let routes = timeTableInfo?.routeInfo else { return }

        routes.forEach { route in
            let view = RouteInfoView()
            view.loadData(from: route)
            routeStackView.addArrangedSubview(view)
        }
    }
}
