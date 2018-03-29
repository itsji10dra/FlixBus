//
//  LoadingIndicator.swift
//  FlixBus
//
//  Created by Jitendra on 28/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import NVActivityIndicatorView

struct LoadingIndicator {

    public static var size: CGFloat = 50

    public static var indicatorColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    public static var textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    public static var backgroundColor = UIColor.black.withAlphaComponent(0.5)

    public static var defaultMessage = "Loading..."

    public static var messageFont = UIFont.boldSystemFont(ofSize: 17)

    public static func startAnimating(message: String? = defaultMessage) {

        let activityData = ActivityData(size: CGSize(width: size, height: size),
                                        message: message,
                                        messageFont: messageFont,
                                        messageSpacing: 10,
                                        type: .lineSpinFadeLoader,
                                        color: indicatorColor,
                                        backgroundColor: backgroundColor,
                                        textColor: textColor)

        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }

    public static func stopAnimating() {

        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
