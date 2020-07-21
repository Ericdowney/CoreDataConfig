
import Foundation

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
