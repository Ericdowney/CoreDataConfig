
import Foundation
import CoreData

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
