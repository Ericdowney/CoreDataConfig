
import Foundation

// MARK: Model Version

public struct ModelVersion: Equatable, Comparable, Codable {
    
    // MARK: - Properties
    
    public var version: Version
    public var model: Model
    
    // MARK: - Lifecyle
    
    public init(_ major: Int, _ minor: Int, _ patch: Int, @VersionBuilder _ builder: () -> Model) {
        self.version = Version(major, minor, patch)
        self.model = builder()
    }
    
    // MARK: - Methods
    
    public static func <(lhs: ModelVersion, rhs: ModelVersion) -> Bool { lhs.version < rhs.version }
}

public struct Version: Equatable, Comparable, Codable {
    
    // MARK: - Properties
    
    public var major: Int
    public var minor: Int
    public var patch: Int
    
    // MARK: - Lifecycle
    
    public init(_ major: Int, _ minor: Int, _ patch: Int) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
    
    // MARK: - Methods
    
    public static func ==(_ lhs: Version, _ rhs: Version) -> Bool {
        lhs.major == rhs.major
            && lhs.minor == rhs.minor
            && lhs.patch == rhs.patch
    }
    
    public static func <(_ lhs: Version, _ rhs: Version) -> Bool {
        lhs.major < rhs.major
            || (lhs.major == rhs.major && lhs.minor < rhs.minor)
            || (lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch < rhs.patch)
    }
}
