//
//  NetworkMonitor.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let backgroundQueue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    private init () {
        self.monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: backgroundQueue)
        monitor.pathUpdateHandler = {[weak self] path in
            if path.status == .satisfied {
                self?.isConnected = true
            } else {
                self?.isConnected = false
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
