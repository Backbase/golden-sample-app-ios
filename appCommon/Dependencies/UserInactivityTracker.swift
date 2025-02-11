//
//  UserInactivityTracker.swift
//  AppCommon
//
//  Created by Backbase on 03/02/2025.
//

import UIKit
import Resolver
import IdentityAuthenticationJourney

/**
 *  A class for tracking user inactivity.
 *
 *  `UserInactivityTracker` monitors user interaction and triggers actions
 *  after a specified period of inactivity. It uses a timer to track the
 *  elapsed time and stores the timeout duration, the time of the last user
 *  interaction, and any remaining time if the tracking is paused.
 */
final class UserInactivityTracker {
    /// The timer used to track user inactivity.
    private var userInactivityTimer: Timer?
    /// The timeout duration in seconds.
    private var timeoutInSeconds: TimeInterval
    /// The time when user inactivity started (i.e., last user interaction).
    private var inactiveStartTime: Date?
    /// The remaining time until timeout, if tracking is paused.
    private var remainingTime: TimeInterval?
    
    init(timeOut: TimeInterval = 5 * 60) {
        timeoutInSeconds = timeOut
        setupObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
     ///
     /// Handles a UI event, resetting the user inactivity timer.
     ///
     /// This method should be called whenever a UI event occurs, indicating user
     /// interaction.  It resets the internal timer, effectively restarting the
     /// inactivity period.  This ensures that the inactivity timeout is only triggered
     /// after a period of *no* user interaction.
     ///
     /// - Parameter event: The UI event that occurred.
     ///
    func handleSendEvent(_ event: UIEvent) {
        guard userInactivityTimer != nil else { return }
        
        let touchBegan = event.allTouches?.first { $0.phase == .began }
        guard touchBegan != nil else { return }
        self.resetIdleTimer()
    }
    
     ///
     /// Updates the timeout threshold for user inactivity.
     ///
     /// This method allows changing the duration of inactivity before the tracker
     /// considers the user inactive.  It cancels any existing timer and restarts
     /// it with the new timeout value.
     ///
     /// - Parameter threshold: The new timeout duration in seconds.
     ///
    func updateTimeOut(threshold: TimeInterval) {
        timeoutInSeconds = threshold
        startInactivityTimer()
    }
    
     ///
     /// Starts the user inactivity timer.
     ///
     /// This method initiates the timer that tracks user inactivity.  It schedules
     /// the timer to fire after the configured timeout duration, at which point
     /// the tracker will consider the user inactive and trigger any associated
     /// actions.  If the timer is already running, this method will restart it.
     ///
    func startInactivityTimer(){
        resetIdleTimer()
    }
    
     ///
     /// Stops the user inactivity timer.
     ///
     /// This method invalidates the timer, preventing it from firing and thus
     /// stopping the tracking of user inactivity.  It effectively pauses the
     /// inactivity monitoring.  Calling this method will prevent any actions
     /// associated with the inactivity timeout from being triggered until the
     /// timer is restarted.
     ///
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
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
    ///
    /// Resets the user inactivity timer.
    ///
    /// This method resets the inactivity timer, effectively restarting the inactivity
    /// period. It is typically called when user interaction is detected, signaling
    /// that the user is still active.  This prevents the inactivity timeout from
    /// being triggered prematurely.  It does *not* necessarily stop and restart
    /// the timer; it may simply reset the timer's internal counter.
    ///
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
