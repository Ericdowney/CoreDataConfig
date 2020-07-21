
import Foundation

public protocol EntityIdentifiable: Equatable, Codable {
    associatedtype Value: Equatable, Codable
    
    var value: Value { get }
    var name: String { get }
}

extension EntityIdentifiable where Self: RawRepresentable, Self.RawValue == Value {
    
    public var value: Value { rawValue }
}

extension EntityIdentifiable where Self: RawRepresentable, Self.RawValue == String {
    
    public var name: String { rawValue.capitalized }
}

extension String: EntityIdentifiable {
    
    public var value: String { self }
    public var name: String { self }
}
