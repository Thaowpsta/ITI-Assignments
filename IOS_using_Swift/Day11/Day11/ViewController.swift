//
//  ViewController.swift
//  Day11
//
//  Created by Thaowpsta Saiid on 13/05/2026.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    let userNotification = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        userNotification.delegate = self

        let authOptions = UNAuthorizationOptions(
            arrayLiteral: .alert,
            .badge,
            .sound
        )

        userNotification.requestAuthorization(options: authOptions) {
            isSuccess,
            error in
            if isSuccess {
                print("notification success")
            }
        }
    }

    @IBAction func timeoutNotification(_ sender: Any) {

        let content = UNMutableNotificationContent()
        content.title = "Hello"
        content.body = "10 Seconds Timeout JETS 46"
        content.badge = NSNumber(value: 1)

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 10,
            repeats: false
        )

        let req = UNNotificationRequest(
            identifier: "timeoutTest",
            content: content,
            trigger: trigger
        )

        userNotification.add(req) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func reminderNotification(_ sender: Any) {

        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "This is your scheduled reminder!"
        content.badge = NSNumber(value: 1)

        let futureDate = Date().addingTimeInterval(15)
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: futureDate
        )
        
//        dateComponents.year = 2026
//            dateComponents.month = 5
//            dateComponents.day = 13
//            dateComponents.hour = 14
//            dateComponents.minute = 30

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        let req = UNNotificationRequest(
            identifier: "reminderTest",
            content: content,
            trigger: trigger
        )

        userNotification.add(req) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
            @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge])
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        
        if let secondVC = storyboard?.instantiateViewController(
            withIdentifier: "SecondViewController"
        ) {
            self.navigationController?.pushViewController(secondVC, animated: true)
        }

        completionHandler()
    }
}
