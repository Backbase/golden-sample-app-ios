//
//  MainErrorFormatter.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 13/11/2023.
//

import Foundation

/// Main Error formatter 
public typealias MainErrorFormatter<E: Error, T> = (E) -> T
