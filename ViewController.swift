//
//  ViewController.swift
//  weather app
//
//  Created by Zachary Cheshire on 11/10/16.
//  Copyright © 2016 zcheshire. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITextFieldDelegate {
    var message = ""
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    //sets up notifications
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let notif = UNMutableNotificationContent()
        notif.title = "CokeWeather"
        notif.subtitle = cityTextField.text!
        notif.body = message
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let request = UNNotificationRequest(identifier: "my notif", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
               print(error)
                completion(false)
            } else {
                completion(true)
            }
            
        })
    }
    @IBAction func getWeather(_ sender: Any) {
    UserDefaults.standard.set(cityTextField.text, forKey: "city")
            }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets up notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {
            (granted, error) in
            
            if granted {
                print("Notification access granted")
            } else {
                print("error")
            }
        })
        
        //resign keyboard upon return
        var i = 0
        var imageArray = [UIImage]()
        var file = ""
        while i <= 121 {
          //  print("frame_\(i)_delay-0.02s.gif")
            file = "frame_\(i)_delay-0.02s.gif"
            imageArray.append(UIImage(named: file)!)
            i = i + 1
        }
       self.imageView.animationImages = imageArray
        self.imageView.animationDuration = 3.0
        self.imageView.startAnimating()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.cityTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


}

