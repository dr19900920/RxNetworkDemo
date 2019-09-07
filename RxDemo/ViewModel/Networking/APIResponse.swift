import Foundation

public struct APIResponseMessage: Decodable {
    public let code: Int
    public let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case code
        case description = "message"
    }
}
