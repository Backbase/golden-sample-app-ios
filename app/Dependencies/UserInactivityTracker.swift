//
//  UserInactivityTracker.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 03/02/2025.
//

import UIKit
import Resolver
import IdentityAuthenticationJourney

final class UserInactivityTracker {
    private var userInactivityTimer: Timer?
    private var timeoutInSeconds: TimeInterval
    private var inactiveStartTime: Date?
    private var remainingTime: TimeInterval?
    
    init(timeOut: TimeInterval = 5 * 60) {
        timeoutInSeconds = timeOut
        setupObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func handleSendEvent(_ event: UIEvent) {
        guard userInactivityTimer != nil else { return }
        
        let touchBegan = event.allTouches?.first { $0.phase == .began }
        guard touchBegan != nil else { return }
        self.resetIdleTimer()
    }
    
    /// Function to update timeout duration
    func updateTimeOut(threshold: TimeInterval) {
        timeoutInSeconds = threshold
        startInactivityTimer()
    }
    
    /// Function to start inactivity timer
    func startInactivityTimer(){
        resetIdleTimer()
    }
    
    /// Function to stop inactivity timer
    func stopInactivityTimer(){
        userInactivityTimer?.invalidate()
        userInactivityTimer = nil
    }
    
    private func expireSession(){
        let authenticationUseCase: AuthenticationUseCase = Resolver.resolve()
        authenticationUseCase.expireSession { _ in }
    }
    
    /// Listen for background/foreground notifications
    private func setupObservers() {
        
    }
    
    @objc private func appDidEnterBackground() {
        inactiveStartTime = Date()
        
        // Invalidate the timer and store the remaining time if needed
        if let userInactivityTimer, userInactivityTimer.isValid {
            let fireDate = userInactivityTimer.fireDate
            remainingTime = fireDate.timeIntervalSinceNow
            stopInactivityTimer()
        }
    }
    
    @objc private func appDidBecomeActive() {
        guard let backgroundTime = inactiveStartTime else {
            resetIdleTimer()
            return
        }
        
        let timeAway = Date().timeIntervalSince(backgroundTime)
        
        // If user was away longer than our threshold, expire the session
        if timeAway >= (remainingTime ?? timeoutInSeconds) {
            expireSession()
        } else {
            let newTimeLeft = (remainingTime ?? timeoutInSeconds) - timeAway
            scheduleTimer(for: newTimeLeft)
        }
        
        inactiveStartTime = nil
    }
}

extension UserInactivityTracker {
    // reset the timer because there was user interaction
    private func resetIdleTimer() {
        if let userInactivityTimer, userInactivityTimer.isValid {
            userInactivityTimer.invalidate()
        }
        scheduleTimer(for: timeoutInSeconds)
    }
    
    private func scheduleTimer(for duration: TimeInterval) {
        stopInactivityTimer()
        
        userInactivityTimer = Timer.scheduledTimer(
            timeInterval: duration,
            target: self,
            selector: #selector(UserInactivityTracker.timeHasExceeded),
            userInfo: nil,
            repeats: false
        )
    }
    
    @objc private func timeHasExceeded() {
        stopInactivityTimer()
        expireSession()
    }
}
