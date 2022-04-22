//
//  ContentView.swift
//  Daily push up
//
//  Created by Maxence Gama on 04/01/2022.
//

import SwiftUI

let hours = [9, 16, 19]
let bodys = [
    "Rappelle-toi que tu as des pompes à faire aujourd'hui ! Crois en toi 🥷",
    "N'oublie pas de faire tes pompes du jour. Esprit Shonen 💪",
    "As-tu bien fait tes pompes jeune warrior ? Sinon viens voir tout de suite combien tu dois en faire !"
]

struct ContentView: View {
    @State private var endDate = Date()
    @State var pushNumb = ""
    
    var body: some View {
        VStack {
            Text("Pompes du jour à faire")
                .font(.title2)
                .padding()
                .multilineTextAlignment(.center)
            Form {
                HStack {
                    Spacer()
                    Text(pushNumb)
                        .padding(.vertical, 30)
                        .multilineTextAlignment(.center)
                        .font(.body)
                    Spacer()
                }
            }
        }
        .onAppear() {
            setupAllNofications()
            pushNumb = "\(dateCalculator(endDate)) pompes pour aujourd'hui"
        }
        
    }
    
    func setupAllNofications() {
        UserDefaults.standard.setValue(false, forKey: "areLocalsPushNotificationsAlreadyRequested")
        let notifSetup = UserDefaults.standard.object(forKey: "areLocalsPushNotificationsAlreadyRequested")
        print(notifSetup)
        if notifSetup == nil || (notifSetup != nil) {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
            for i in 0..<3 {
                let content = UNMutableNotificationContent()
                content.title = "C'est l'heure des pompes !"
                content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "mixkit-sci-fi-click-900.wav"))
                
                var dateComponents = DateComponents()
                dateComponents.minute = 0
                
                content.body = bodys[i]
                dateComponents.hour = hours[i]

                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                let request = UNNotificationRequest(identifier: "dailyNotification\(i)", content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request) { (error: Error?) in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else {
                        print("Request \(i) accepted", request)
                    }
                }
            }
            
            UserDefaults.standard.setValue(true, forKey: "areLocalsPushNotificationsAlreadyRequested")
        }
    }
    
    func testSetupAllNofications() {
        let content = UNMutableNotificationContent()
        content.title = "C'est l'heure des pompes !"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "mixkit-sci-fi-click-900.wav"))
        
        var dateComponents = DateComponents()
        
        content.body = "N'oublie pas de faire tes pompes du jour. C'est \(dateCalculator(endDate)) pour aujourd'hui. Esprit Shonen 💪"
        
        dateComponents.hour = 22
        dateComponents.minute = 3

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error: Error?) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Request accepted")
            }
        }
    }
    
    private func dateCalculator(_ end: Date) -> Int {
        var dateComponents = DateComponents()
        dateComponents.year = 2022
        dateComponents.month = 1
        dateComponents.day = 1
        let start = Calendar(identifier: .gregorian).date(from: dateComponents)!
        let diff = end.interval(ofComponent: .day, fromDate: start)
        
        return diff
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Date {
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {

        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
}
