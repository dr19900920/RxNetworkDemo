import Foundation

public extension Collection {
    var isNonempty: Bool {
        return !isEmpty
    }
    
    func ifNonempty<U>(_ transform: (Self) throws -> U) rethrows -> U? {
        guard self.isNonempty else {
            return nil
        }
        return try transform(self)
    }
}
