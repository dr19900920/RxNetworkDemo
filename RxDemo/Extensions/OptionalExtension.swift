import Foundation

extension Optional where Wrapped: Collection {
    public var isEmpty: Bool {
        guard let wrapped = self else { return true }
        return wrapped.isEmpty
    }
    
    public var isNonempty: Bool {
        return !isEmpty
    }
    
    /// Evaluates the given closure when this `Optional` instance is not empty,
    /// passing the non-empty value as a parameter.
    ///
    /// When you need to use the non-empty value:
    /// ```
    /// var optionalString: String?
    /// let string = optionalString.map { $0.isEmpty ? defaultValue : $0 } ?? defaultValue
    /// ```
    /// use this function instead:
    /// ```
    /// var optionalString: String?
    /// let string = optionalString.ifNonempty { $0 } ?? defaultValue
    /// ```
    public func ifNonempty<U>(_ transform: (Wrapped) throws -> U) rethrows -> U? {
        guard let wrapped = self else { return nil }
        return try wrapped.ifNonempty(transform)
    }
}
