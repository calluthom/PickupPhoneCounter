//
//  ContentView.swift
//  Pickup
//
//  Created by Callum Thomas on 2023-01-06.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    
    // get the device picked up count from local storage
    @State private var devicePickedUpCount = UserDefaults.standard.integer(forKey: "Pickup")
    
    // create a motion activity manager
    let activityCenter = CMMotionActivityManager()
    
    // ui for the counter
    var body: some View {
        VStack {
            Spacer()
            Text("\(devicePickedUpCount)")
                .font(.system(size: 200))
                .onAppear {
                    self.startMonitoringDeviceActivity()
                }
            Spacer()
            Text("You have picked up your phone \(devicePickedUpCount) times")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
    }
    
    // monitor device activity and increment the count when the device is picked up
    func startMonitoringDeviceActivity() {
        activityCenter.startActivityUpdates(to: .main) { (activity: CMMotionActivity?) in
            if let activity = activity {
                // Check if the device was picked up
                if activity.stationary == false && activity.walking == false && activity.running == false && activity.automotive == false && activity.cycling == false {
                    
                    // Device was picked up
                    self.devicePickedUpCount += 1
                    
                    // store the pickup count in the local device storage
                    UserDefaults.standard.set(self.devicePickedUpCount, forKey: "Pickup")
                }
            }
        }
    }
}

// preview code, for easy editing in xCode
struct ContentViewPreview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
