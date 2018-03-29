//
//  RouteInfoView.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import MapKit

class RouteInfoView: UIView {
    
    // MARK: - IBOutlets

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var addressLabel: UILabel!
    @IBOutlet weak private var mapButton: UIButton!

    // MARK: - Data
    
    private var mapCompletionBlock: (() -> Void)?

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.configureView()
    }

    private func configureView() {
        let view = loadView(fromNib: "RouteInfoView")
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }

    // MARK: - Actions

    @IBAction func navigateToMapAction(_ sender: Any) {
        
        mapCompletionBlock?()
    }
    
    // MARK: - Internal Methods
    
    internal func loadData(from route: RouteInfo) {
        
        nameLabel.text = route.name
        addressLabel.text = route.fullAddress
        
        mapCompletionBlock = {
            guard let latitude = route.coordinates?.latitude,
                let longitude = route.coordinates?.longitude else { return  }
            
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = route.name
            mapItem.openInMaps(launchOptions: nil)
        }
    }
}
