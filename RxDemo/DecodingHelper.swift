import Foundation

public struct GenericCodingKey: CodingKey {
    public let stringValue: String
    
    public init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    public var intValue: Int?
    
    public init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
    }
    
    public init(name: String) {
        self.init(stringValue: name)!
    }
}
