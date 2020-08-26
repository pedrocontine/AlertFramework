//
//  ViewController.swift
//  AlertApp
//
//  Created by Pedro Contine on 26/08/20.
//  Copyright © 2020 Pedro Contine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var alertController: AlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let availableAlerts = [Alert(type: .error, handler: errorAlertHandler)]
        alertController = AlertController(alerts: availableAlerts)
        alertController?.delegate = self
        
        self.alertController?.show(type: .error)
    }
    
    func errorAlertHandler() {
        print("alert handler example")
    }
}

extension ViewController: AlertControllerDelegate {
    func willDisplay(alert: UIAlertController?) {
        guard let alert = alert else { return }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
