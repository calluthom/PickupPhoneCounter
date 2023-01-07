//
//  ContentView.swift
//  Pickup
//
//  Created by Callum Thomas on 2023-01-06.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @State private var devicePickedUpCount = 0
    let activityCenter = CMMotionActivityManager()

    var body: some View {
        VStack {
            Text("Device picked up count: \(devicePickedUpCount)")
                .onAppear {
                    self.startMonitoringDeviceActivity()
                }
        }
    }

    func startMonitoringDeviceActivity() {
        activityCenter.startActivityUpdates(to: .main) { (activity: CMMotionActivity?) in
            if let activity = activity {
                // Check if the device was picked up
                if activity.stationary == false && activity.walking == false && activity.running == false && activity.automotive == false && activity.cycling == false {
                    // Device was picked up
                    self.devicePickedUpCount += 1
                }
            }
        }
    }
}
