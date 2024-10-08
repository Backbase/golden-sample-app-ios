//
// ArrangementsAPIRequestParams.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech

import Foundation
import ClientCommonGen2

public extension ArrangementsAPI {
    /// This class is used as a container class for request parameters for ArrangementsAPI.getArrangementById API call.
    struct GetArrangementByIdRequestParams: Equatable {
            /** Arrangement Id */
    public let arrangementId: String
    /** Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. */
    public let contentLanguage: String?
    /** Masked/Unmasked card number */
    public let maskIndicator: Bool?

    internal init(arrangementId: String, contentLanguage: String?, maskIndicator: Bool?) {
        self.arrangementId = arrangementId
        self.contentLanguage = contentLanguage
        self.maskIndicator = maskIndicator
    }
    /// Builder class for GetArrangementByIdRequestParams DTO.
    public final class Builder: Equatable {
        /** Arrangement Id */
        public let arrangementId: String
        /** Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. */
        public private(set) var contentLanguage: String?
        /** Masked/Unmasked card number */
        public private(set) var maskIndicator: Bool?

        public init(arrangementId: String) {
            self.arrangementId = arrangementId
        }

        /// Setter method for contentLanguage property.
        public func set(contentLanguage: String?) -> Self {
            self.contentLanguage = contentLanguage
            return self
        }
        /// Setter method for maskIndicator property.
        public func set(maskIndicator: Bool?) -> Self {
            self.maskIndicator = maskIndicator
            return self
        }

        /// Builder initializer method for GetArrangementByIdRequestParams DTO.
        public func build() -> GetArrangementByIdRequestParams {
            return GetArrangementByIdRequestParams(arrangementId: arrangementId, 
            		contentLanguage: contentLanguage, 
            		maskIndicator: maskIndicator)
        }

        public static func ==(lhs: Builder, rhs: Builder) -> Bool {
        	return lhs.arrangementId == rhs.arrangementId &&
        	lhs.contentLanguage == rhs.contentLanguage &&
        	lhs.maskIndicator == rhs.maskIndicator
    	}
    }

public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.arrangementId == rhs.arrangementId &&
    lhs.contentLanguage == rhs.contentLanguage &&
    lhs.maskIndicator == rhs.maskIndicator
}
    }
    /// This class is used as a container class for request parameters for ArrangementsAPI.getArrangementChildren API call.
    struct GetArrangementChildrenRequestParams: Equatable {
            /** Arrangement Id */
    public let arrangementId: String
    /** Page Number. Skip over pages of elements by specifying a start value for the query */
    public let from: Int?
    /** Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  */
    public let size: Int?

    internal init(arrangementId: String, from: Int?, size: Int?) {
        self.arrangementId = arrangementId
        self.from = from
        self.size = size
    }
    /// Builder class for GetArrangementChildrenRequestParams DTO.
    public final class Builder: Equatable {
        /** Arrangement Id */
        public let arrangementId: String
        /** Page Number. Skip over pages of elements by specifying a start value for the query */
        public private(set) var from: Int? = 0
        /** Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  */
        public private(set) var size: Int? = 10

        public init(arrangementId: String) {
            self.arrangementId = arrangementId
        }

        /// Setter method for from property.
        public func set(from: Int?) -> Self {
            self.from = from
            return self
        }
        /// Setter method for size property.
        public func set(size: Int?) -> Self {
            self.size = size
            return self
        }

        /// Builder initializer method for GetArrangementChildrenRequestParams DTO.
        public func build() -> GetArrangementChildrenRequestParams {
            return GetArrangementChildrenRequestParams(arrangementId: arrangementId, 
            		from: from, 
            		size: size)
        }

        public static func ==(lhs: Builder, rhs: Builder) -> Bool {
        	return lhs.arrangementId == rhs.arrangementId &&
        	lhs.from == rhs.from &&
        	lhs.size == rhs.size
    	}
    }

public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.arrangementId == rhs.arrangementId &&
    lhs.from == rhs.from &&
    lhs.size == rhs.size
}
    }
    /// This class is used as a container class for request parameters for ArrangementsAPI.getLinked API call.
    struct GetLinkedRequestParams: Equatable {
            /** External Legal entity Id */
    public let legalEntityId: String
    /** Page Number. Skip over pages of elements by specifying a start value for the query */
    public let from: Int?
    /** Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  */
    public let size: Int?

    internal init(legalEntityId: String, from: Int?, size: Int?) {
        self.legalEntityId = legalEntityId
        self.from = from
        self.size = size
    }
    /// Builder class for GetLinkedRequestParams DTO.
    public final class Builder: Equatable {
        /** External Legal entity Id */
        public let legalEntityId: String
        /** Page Number. Skip over pages of elements by specifying a start value for the query */
        public private(set) var from: Int? = 0
        /** Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  */
        public private(set) var size: Int? = 10

        public init(legalEntityId: String) {
            self.legalEntityId = legalEntityId
        }

        /// Setter method for from property.
        public func set(from: Int?) -> Self {
            self.from = from
            return self
        }
        /// Setter method for size property.
        public func set(size: Int?) -> Self {
            self.size = size
            return self
        }

        /// Builder initializer method for GetLinkedRequestParams DTO.
        public func build() -> GetLinkedRequestParams {
            return GetLinkedRequestParams(legalEntityId: legalEntityId, 
            		from: from, 
            		size: size)
        }

        public static func ==(lhs: Builder, rhs: Builder) -> Bool {
        	return lhs.legalEntityId == rhs.legalEntityId &&
        	lhs.from == rhs.from &&
        	lhs.size == rhs.size
    	}
    }

public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.legalEntityId == rhs.legalEntityId &&
    lhs.from == rhs.from &&
    lhs.size == rhs.size
}
    }
    /// This class is used as a container class for request parameters for ArrangementsAPI.getUserPreferences API call.
    struct GetUserPreferencesRequestParams: Equatable {
            /** arrangement id */
    public let arrangementId: String

    internal init(arrangementId: String) {
        self.arrangementId = arrangementId
    }
    /// Builder class for GetUserPreferencesRequestParams DTO.
    public final class Builder: Equatable {
        /** arrangement id */
        public let arrangementId: String

        public init(arrangementId: String) {
            self.arrangementId = arrangementId
        }


        /// Builder initializer method for GetUserPreferencesRequestParams DTO.
        public func build() -> GetUserPreferencesRequestParams {
            return GetUserPreferencesRequestParams(arrangementId: arrangementId)
        }

        public static func ==(lhs: Builder, rhs: Builder) -> Bool {
        	return lhs.arrangementId == rhs.arrangementId
    	}
    }

public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.arrangementId == rhs.arrangementId
}
    }
    /// This class is used as a container class for request parameters for ArrangementsAPI.linkExternalLegalEntity API call.
    struct LinkExternalLegalEntityRequestParams: Equatable {
            /** external legal entity id */
    public let externalLegalEntityId: String
    public let accountLinkedArrangementItem: AccountLinkedArrangementItem

    internal init(externalLegalEntityId: String, accountLinkedArrangementItem: AccountLinkedArrangementItem) {
        self.externalLegalEntityId = externalLegalEntityId
        self.accountLinkedArrangementItem = accountLinkedArrangementItem
    }
    /// Builder class for LinkExternalLegalEntityRequestParams DTO.
    public final class Builder: Equatable {
        /** external legal entity id */
        public let externalLegalEntityId: String
        public let accountLinkedArrangementItem: AccountLinkedArrangementItem

        public init(externalLegalEntityId: String, accountLinkedArrangementItem: AccountLinkedArrangementItem) {
            self.externalLegalEntityId = externalLegalEntityId
            self.accountLinkedArrangementItem = accountLinkedArrangementItem
        }


        /// Builder initializer method for LinkExternalLegalEntityRequestParams DTO.
        public func build() -> LinkExternalLegalEntityRequestParams {
            return LinkExternalLegalEntityRequestParams(externalLegalEntityId: externalLegalEntityId, 
            		accountLinkedArrangementItem: accountLinkedArrangementItem)
        }

        public static func ==(lhs: Builder, rhs: Builder) -> Bool {
        	return lhs.externalLegalEntityId == rhs.externalLegalEntityId &&
        	lhs.accountLinkedArrangementItem == rhs.accountLinkedArrangementItem
    	}
    }

public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.externalLegalEntityId == rhs.externalLegalEntityId &&
    lhs.accountLinkedArrangementItem == rhs.accountLinkedArrangementItem
}
    }
    /// This class is used as a container class for request parameters for ArrangementsAPI.unlinkExternalLegalEntity API call.
    struct UnlinkExternalLegalEntityRequestParams: Equatable {
            /** external legal entity id */
    public let externalLegalEntityId: String
    /** external arrangement id */
    public let externalArrangementId: String

    internal init(externalLegalEntityId: String, externalArrangementId: String) {
        self.externalLegalEntityId = externalLegalEntityId
        self.externalArrangementId = externalArrangementId
    }
    /// Builder class for UnlinkExternalLegalEntityRequestParams DTO.
    public final class Builder: Equatable {
        /** external legal entity id */
        public let externalLegalEntityId: String
        /** external arrangement id */
        public let externalArrangementId: String

        public init(externalLegalEntityId: String, externalArrangementId: String) {
            self.externalLegalEntityId = externalLegalEntityId
            self.externalArrangementId = externalArrangementId
        }


        /// Builder initializer method for UnlinkExternalLegalEntityRequestParams DTO.
        public func build() -> UnlinkExternalLegalEntityRequestParams {
            return UnlinkExternalLegalEntityRequestParams(externalLegalEntityId: externalLegalEntityId, 
            		externalArrangementId: externalArrangementId)
        }

        public static func ==(lhs: Builder, rhs: Builder) -> Bool {
        	return lhs.externalLegalEntityId == rhs.externalLegalEntityId &&
        	lhs.externalArrangementId == rhs.externalArrangementId
    	}
    }

public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.externalLegalEntityId == rhs.externalLegalEntityId &&
    lhs.externalArrangementId == rhs.externalArrangementId
}
    }
    /// This class is used as a container class for request parameters for ArrangementsAPI.unmaskedAttribute API call.
    struct UnmaskedAttributeRequestParams: Equatable {
            /** Arrangement Id */
    public let arrangementId: String
    /** The attribute to be unmasked */
    public let attributeName: MaskableAttribute

    internal init(arrangementId: String, attributeName: MaskableAttribute) {
        self.arrangementId = arrangementId
        self.attributeName = attributeName
    }
    /// Builder class for UnmaskedAttributeRequestParams DTO.
    public final class Builder: Equatable {
        /** Arrangement Id */
        public let arrangementId: String
        /** The attribute to be unmasked */
        public let attributeName: MaskableAttribute

        public init(arrangementId: String, attributeName: MaskableAttribute) {
            self.arrangementId = arrangementId
            self.attributeName = attributeName
        }


        /// Builder initializer method for UnmaskedAttributeRequestParams DTO.
        public func build() -> UnmaskedAttributeRequestParams {
            return UnmaskedAttributeRequestParams(arrangementId: arrangementId, 
            		attributeName: attributeName)
        }

        public static func ==(lhs: Builder, rhs: Builder) -> Bool {
        	return lhs.arrangementId == rhs.arrangementId &&
        	lhs.attributeName == rhs.attributeName
    	}
    }

public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.arrangementId == rhs.arrangementId &&
    lhs.attributeName == rhs.attributeName
}
    }
    /// This class is used as a container class for request parameters for ArrangementsAPI.updateUserPreferences API call.
    struct UpdateUserPreferencesRequestParams: Equatable {
            public let accountUserPreferences: AccountUserPreferences

    internal init(accountUserPreferences: AccountUserPreferences) {
        self.accountUserPreferences = accountUserPreferences
    }
    /// Builder class for UpdateUserPreferencesRequestParams DTO.
    public final class Builder: Equatable {
        public let accountUserPreferences: AccountUserPreferences

        public init(accountUserPreferences: AccountUserPreferences) {
            self.accountUserPreferences = accountUserPreferences
        }


        /// Builder initializer method for UpdateUserPreferencesRequestParams DTO.
        public func build() -> UpdateUserPreferencesRequestParams {
            return UpdateUserPreferencesRequestParams(accountUserPreferences: accountUserPreferences)
        }

        public static func ==(lhs: Builder, rhs: Builder) -> Bool {
        	return lhs.accountUserPreferences == rhs.accountUserPreferences
    	}
    }

public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.accountUserPreferences == rhs.accountUserPreferences
}
    }
}
