import Foundation
import Alamofire
import Moya

public protocol BaseAPI: TargetType {
    typealias Parameters = [String: Any]
    typealias HTTPMethod = Moya.Method
    
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    var parameterEncoding: ParameterEncoding { get }
}

public extension BaseAPI {
    static var baseURL: URL {
        // MARK -: 需要自己的burl测试
        return URL(string: "www.baidu.com")!
    }
    
    var urlString: String {
        return baseURL.appendingPathComponent(path).absoluteString
    }
}

public extension BaseAPI {
    var baseURL: URL {
        return Self.baseURL
    }
    
    var task: Task {
        if method == .post {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        } else {
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
}
