import Foundation
import Alamofire

public enum ViewControllerAPI: BaseAPI {
    case version(name: String, type: Int)
}

extension ViewControllerAPI {
    public var path: String {
        switch self {
        case .version:
            return "/appVersionInfo/appVersion"
        }
    }
    
    public var parameters: Parameters {
        switch self {
        case let .version(name, type):
            return ["versionName": name, "versionType": type]
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .version:
            return .post
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
