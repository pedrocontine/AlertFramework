//
//  AlertController.swift
//  AlertApp
//
//  Created by Pedro Contine on 26/08/20.
//  Copyright © 2020 Pedro Contine. All rights reserved.
//

import UIKit

typealias handler = (() -> Void)?

enum AlertType {
    case none
    case error
}

struct Alert {
    var type: AlertType
    var handler: handler = nil
}

protocol AlertControllerDelegate: class {
    func willDisplay(alert: UIAlertController?)
}

class AlertController {
    
    weak var delegate: AlertControllerDelegate?
    
    private var configuredAlerts: [Alert]
    private var alertToDisplay: UIAlertController? {
        didSet {
            delegate?.willDisplay(alert: alertToDisplay)
        }
    }
    
    init(alerts: [Alert]) {
        self.configuredAlerts = alerts
    }
    
    func show(type: AlertType) {
        let handler = configuredAlerts.filter({ $0.type == type }).first?.handler
        alertToDisplay = alertFor(type: type, withHandler: handler)
    }
    
    private func alertFor(type: AlertType, withHandler: handler) -> UIAlertController? {
        switch type {
        case .none:
            return nil
        case .error:
            return simpleAlertExample(handler: withHandler)
        }
    }
    
    private func simpleAlertExample(handler: handler) -> UIAlertController {
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let handler = handler { handler() }
        }
        return alertWith(title: "Title", message: "message", actions: [okAction])
    }
    
    private func alertWith(title: String, message: String, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        return alert
    }
    
}
