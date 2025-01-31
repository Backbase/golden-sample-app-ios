//
//  UserRepository+Extensions.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 31/01/2025.
//

import Resolver
import BackbaseSecureStorage
import BusinessJourneyCommon

extension UserRepository {
    public enum Keys: String {
        case targetLegalEntityIdentifier
        case persistedServiceAgreementName
        case persistedServiceAgreementIdentifier
    }
    
    public var targetLegalEntityIdentifier: String? {
        get { Resolver.optional(name: Keys.targetLegalEntityIdentifier.rawValue) }
        set { Resolver.register(name: Keys.targetLegalEntityIdentifier.rawValue){ newValue } }
    }
    
    public var persistedServiceAgreementName: String? {
        get {
            let secureStorageInfo: SecureStorageInfo = Resolver.resolve()
            let result = secureStorageInfo.storage.readValue(forKey: Keys.persistedServiceAgreementName.rawValue)
            if case let .success(name) = result {
                return name
            }
            return nil
        }
        
        set {
            let secureStorageInfo: SecureStorageInfo = Resolver.resolve()
            if let newValue {
                secureStorageInfo.storage.storeValue(newValue, forKey: Keys.persistedServiceAgreementName.rawValue)
            } else {
                secureStorageInfo.storage.deleteValue(forKey: Keys.persistedServiceAgreementName.rawValue)
            }
        }
    }
    
    public var persistedServiceAgreementIdentifier: String? {
        get {
            let secureStorageInfo: SecureStorageInfo = Resolver.resolve()
            let result = secureStorageInfo.storage.readValue(forKey: Keys.persistedServiceAgreementIdentifier.rawValue)
            if case let .success(identifier) = result {
                return identifier
            }
            return nil
        }
        
        set {
            let secureStorageInfo: SecureStorageInfo = Resolver.resolve()
            if let newValue {
                secureStorageInfo.storage.storeValue(newValue, forKey: Keys.persistedServiceAgreementIdentifier.rawValue)
            } else {
                secureStorageInfo.storage.deleteValue(forKey: Keys.persistedServiceAgreementIdentifier.rawValue)
            }
        }
    }
    public func clearPersistedServiceAgreement() {
        self.persistedServiceAgreementName = nil
        self.persistedServiceAgreementIdentifier = nil
    }
}
