//
//  UIView+Extension.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Load nib from string
    
    func loadView(fromNib nib: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view ?? UIView()
    }
}

