import Foundation

public struct Version {
    public let code: String
    public let updateURL: URL?
    public let needUpdate: Bool
    public let description: String?
}

extension Version: Decodable {
    private enum CodingKeys: String, CodingKey {
        case code       = "version"
        case updateURL  = "apkUrl"
        case needUpdate = "isUpdate"
        case description
    }
}
