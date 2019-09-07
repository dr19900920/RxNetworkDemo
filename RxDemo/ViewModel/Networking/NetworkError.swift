import Foundation
import Moya

public enum NetworkError: Error {
    public typealias Library = Moya.MoyaError
    public typealias Internal = APIResponseMessage
    
    case library(Library)
    case buildinDecoding(Error)
    case `internal`(Internal)
}

extension NetworkError: CustomStringConvertible, CustomDebugStringConvertible {
    private var emptyDescription: String { return "" }
    private var defaultDescription: String { return "请求失败" }
    
    public var description: String {
        switch self {
        case .library(let error):
            return error.errorDescription ?? defaultDescription
        case .buildinDecoding(let error):
            return (error as NSError).description
        case .internal(let error):
            return error.description ?? defaultDescription
        }
    }
    
    public var debugDescription: String {
        switch self {
        case .library(let error):
            return error.errorDescription.map { "Network error: Moya error: \($0)" } ?? defaultDescription
        case .buildinDecoding(let error):
            return "Network error: Swift decoding error \((error as NSError).description)"
        case .internal(let error):
            return "Network error: internal error \(error.code) - \(error.description ?? emptyDescription)"
        }
    }
}
