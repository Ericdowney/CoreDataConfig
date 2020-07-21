
import Foundation
import CoreData

// MARK: - Attribute

public struct AnyValue: Equatable, Codable {
    
    // MARK: - Properties
    
    var value: Any? {
        if let value = value_string {
            return value
        }
        else if let value = value_uuid {
            return value
        }
        else if let value = value_int16 {
            return value
        }
        else if let value = value_int32 {
            return value
        }
        else if let value = value_int64 {
            return value
        }
        else if let value = value_decimal {
            return value
        }
        else if let value = value_double {
            return value
        }
        else if let value = value_float {
            return value
        }
        else if let value = value_boolean {
            return value
        }
        else if let value = value_date {
            return value
        }
        else if let value = value_data {
            return value
        }
        else if let value = value_uri {
            return value
        }
        return nil
    }
    
    private var value_string: String?
    private var value_uuid: UUID?
    private var value_int16: Int16?
    private var value_int32: Int32?
    private var value_int64: Int64?
    private var value_decimal: Decimal?
    private var value_double: Double?
    private var value_float: Float?
    private var value_boolean: Bool?
    private var value_date: Date?
    private var value_data: Data?
    private var value_uri: URL?
    
    // MARK: - Lifecycle
    
    public init(_ value: String?) {
        self.value_string = value
    }
    
    public init(_ value: UUID?) {
        self.value_uuid = value
    }
    
    public init(_ value: Int16?) {
        self.value_int16 = value
    }
    
    public init(_ value: Int32?) {
        self.value_int32 = value
    }
    
    public init(_ value: Int64?) {
        self.value_int64 = value
    }
    
    public init(_ value: Decimal?) {
        self.value_decimal = value
    }
    
    public init(_ value: Double?) {
        self.value_double = value
    }
    
    public init(_ value: Float?) {
        self.value_float = value
    }
    
    public init(_ value: Bool?) {
        self.value_boolean = value
    }
    
    public init(_ value: Date?) {
        self.value_date = value
    }
    
    public init(_ value: Data?) {
        self.value_data = value
    }
    
    public init(_ value: URL?) {
        self.value_uri = value
    }
    
    // MARK: - Methods
    
}

public struct Attribute: Equatable, Codable {
    public enum AttributeType: Int, Codable {
        case string, uuid, int16, int32, int64, decimal, double, float, boolean, date, data, uri
        
        var attributeType: NSAttributeType {
            switch self {
            case .string: return NSAttributeType.stringAttributeType
            case .uuid: return NSAttributeType.UUIDAttributeType
            case .int16: return NSAttributeType.integer16AttributeType
            case .int32: return NSAttributeType.integer32AttributeType
            case .int64: return NSAttributeType.integer64AttributeType
            case .decimal: return NSAttributeType.decimalAttributeType
            case .double: return NSAttributeType.doubleAttributeType
            case .float: return NSAttributeType.floatAttributeType
            case .boolean: return NSAttributeType.booleanAttributeType
            case .date: return NSAttributeType.dateAttributeType
            case .data: return NSAttributeType.binaryDataAttributeType
            case .uri: return NSAttributeType.URIAttributeType
            }
        }
    }
    
    // MARK: - Properties
    
    public var name: String
    public var type: AttributeType
    public var isTransient: Bool = false
    public var isOptional: Bool = false
    public var allowsExternalBinaryDataStorage: Bool = false
    public var isIndexedBySpotlight: Bool = false
    public var attributeValueClassName: String? = nil
    public var valueTransformerName: String? = nil
    public var preservesValueInHistoryOnDeletion: Bool = false
    public var defaultValue: AnyValue? = nil
    public var renamingIdentifier: String = ""
    
    public var isValid: Bool {
        (isTransient && !isIndexedBySpotlight) || (!isTransient && isIndexedBySpotlight) || (!isTransient && !isIndexedBySpotlight)
    }
    
    // MARK: - Lifecycle
    
    public init(_ name: String, type: AttributeType) {
        self.name = name
        self.type = type
    }
    
    init(_ name: String,
         _ type: AttributeType,
         _ isTransient: Bool,
         _ isOptional: Bool,
         _ allowsExternalBinaryDataStorage: Bool,
         _ isIndexedBySpotlight: Bool,
         _ attributeValueClassName: String?,
         _ valueTransformerName: String?,
         _ preservesValueInHistoryOnDeletion: Bool,
         _ defaultValue: AnyValue?,
         _ renamingIdentifier: String) {
        self.name = name
        self.type = type
        self.isTransient = isTransient
        self.isOptional = isOptional
        self.allowsExternalBinaryDataStorage = allowsExternalBinaryDataStorage
        self.isIndexedBySpotlight = isIndexedBySpotlight
        self.attributeValueClassName = attributeValueClassName
        self.valueTransformerName = valueTransformerName
        self.preservesValueInHistoryOnDeletion = preservesValueInHistoryOnDeletion
        self.defaultValue = defaultValue
        self.renamingIdentifier = renamingIdentifier
    }
    
    // MARK: - Methods
    
    public func isTransient(_ value: Bool) -> Self {
        .init(name,
              type,
              value,
              isOptional,
              allowsExternalBinaryDataStorage,
              isIndexedBySpotlight,
              attributeValueClassName,
              valueTransformerName,
              preservesValueInHistoryOnDeletion,
              defaultValue,
              renamingIdentifier)
    }
    
    public func isOptional(_ value: Bool) -> Self {
        .init(name,
              type,
              isTransient,
              value,
              allowsExternalBinaryDataStorage,
              isIndexedBySpotlight,
              attributeValueClassName,
              valueTransformerName,
              preservesValueInHistoryOnDeletion,
              defaultValue,
              renamingIdentifier)
    }
    
    public func allowsExternalBinaryDataStorage(_ value: Bool) -> Self {
        .init(name,
              type,
              isTransient,
              isOptional,
              value,
              isIndexedBySpotlight,
              attributeValueClassName,
              valueTransformerName,
              preservesValueInHistoryOnDeletion,
              defaultValue,
              renamingIdentifier)
    }

    public func isIndexedBySpotlight(_ value: Bool) -> Self {
        .init(name,
              type,
              isTransient,
              isOptional,
              allowsExternalBinaryDataStorage,
              value,
              attributeValueClassName,
              valueTransformerName,
              preservesValueInHistoryOnDeletion,
              defaultValue,
              renamingIdentifier)
    }
    
    public func attributeValueClassName(_ value: String?) -> Self {
        .init(name,
              type,
              isTransient,
              isOptional,
              allowsExternalBinaryDataStorage,
              isIndexedBySpotlight,
              value,
              valueTransformerName,
              preservesValueInHistoryOnDeletion,
              defaultValue,
              renamingIdentifier)
    }
    
    public func valueTransformerName(_ value: String?) -> Self {
        .init(name,
              type,
              isTransient,
              isOptional,
              allowsExternalBinaryDataStorage,
              isIndexedBySpotlight,
              attributeValueClassName,
              value,
              preservesValueInHistoryOnDeletion,
              defaultValue,
              renamingIdentifier)
    }
    
    public func preservesValueInHistoryOnDeletion(_ value: Bool) -> Self {
        .init(name,
              type,
              isTransient,
              isOptional,
              allowsExternalBinaryDataStorage,
              isIndexedBySpotlight,
              attributeValueClassName,
              valueTransformerName,
              value,
              defaultValue,
              renamingIdentifier)
    }
    
    public func defaultValue(_ value: AnyValue?) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, value, renamingIdentifier)
    }
    
    public func defaultValue(_ value: String) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func defaultValue(_ value: UUID) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func defaultValue(_ value: Int16) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func defaultValue(_ value: Int32) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func defaultValue(_ value: Int64) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func defaultValue(_ value: Decimal) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func defaultValue(_ value: Double) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func defaultValue(_ value: Float) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func defaultValue(_ value: Bool) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func defaultValue(_ value: Date) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func defaultValue(_ value: Data) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func defaultValue(_ value: URL) -> Self {
        .init(name, type, isTransient, isOptional, allowsExternalBinaryDataStorage, isIndexedBySpotlight, attributeValueClassName, valueTransformerName, preservesValueInHistoryOnDeletion, .init(value), renamingIdentifier)
    }
    
    public func renamingIdentifier(_ value: String) -> Self {
        .init(name,
              type,
              isTransient,
              isOptional,
              allowsExternalBinaryDataStorage,
              isIndexedBySpotlight,
              attributeValueClassName,
              valueTransformerName,
              preservesValueInHistoryOnDeletion,
              defaultValue,
              value)
    }
}

extension Attribute {
    enum Errors: Error {
        case invalidAttribute(Attribute)
    }
    
    func createAttributeDescription() throws -> NSAttributeDescription {
        guard isValid else { throw Errors.invalidAttribute(self) }
        
        let description = NSAttributeDescription()
        description.name = name
        description.attributeType = type.attributeType
        description.isTransient = isTransient
        description.isOptional = isOptional
        description.renamingIdentifier = renamingIdentifier
        description.allowsExternalBinaryDataStorage = allowsExternalBinaryDataStorage
        description.isIndexedBySpotlight = isIndexedBySpotlight
        description.defaultValue = defaultValue?.value
        if let attributeValueClassName = attributeValueClassName {
            description.attributeValueClassName = attributeValueClassName
        }
        if let valueTransformerName = valueTransformerName {
            description.valueTransformerName = valueTransformerName
        }
        description.preservesValueInHistoryOnDeletion = preservesValueInHistoryOnDeletion
        
        return description
    }
}
