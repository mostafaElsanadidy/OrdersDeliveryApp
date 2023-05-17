//
//  TimerUIApplication.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 17.05.23.
//

import Foundation

import UIKit

final class Application: UIApplication {
    
  // MARK: - Properties
  
  static let sessionExpiredNotification = Notification(name: Notification.Name(rawValue: "sessionExpiredNotification"))

  private var idleTimer: Timer?
  
  private let timeoutInSeconds: TimeInterval =  2 * 60  // 2 minutes
  
  // MARK: - Initialisation
  
  override init() {
    super.init()
    startIdleTimer()
  }
  
  // MARK: - Actions
  
  private func startIdleTimer() {
    // Starts and schedules (fires) the times to the given time interval
    idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds,
                                     target: self,
                                     selector: #selector(timeHasExceeded),
                                     userInfo: nil,
                                     repeats: false
    )
  }

  private func resetIdleTimer() {
    // Invalidates (cancels) the timer
    idleTimer?.invalidate()
    // Re-schedules it
    startIdleTimer()
  }

  // MARK: - Events
  
  @objc private func timeHasExceeded() {
      print("Time Out")
      NotificationCenter.default.post(Notification(name: Application.sessionExpiredNotification.name))
  }
  
  // MARK: - Interaction

  override func sendEvent(_ event: UIEvent) {
    // The idle will be reset every time a new touch is caught from the Event Thread.
    guard let touches = event.allTouches
        else { return }
    if !touches.filter({ $0.phase == UITouch.Phase.began }).isEmpty {
      resetIdleTimer()
    }
    // ... BEFORE forwarding the event to its responder
    super.sendEvent(event)
  }
}
