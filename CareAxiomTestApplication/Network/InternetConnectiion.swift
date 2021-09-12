//
//  InternetConnectiion.swift
//  CareAxiomTestApplication
//
//  Created by Khawaja Salman Nadeem on 12/09/2021.
//

import Foundation
import Network

class InternetConnection {
    static let sharedInstance = InternetConnection()
    var isInternetConnected = false
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    func initialise() {
        monitor.pathUpdateHandler = { pathUpdateHandler in
                    if pathUpdateHandler.status == .satisfied {
                        print("Internet connection is on.")
                        self.isInternetConnected = true
                    } else {
                        print("There's no internet connection.")
                        self.isInternetConnected = false
                    }
                }
                monitor.start(queue: queue)
    }
}
