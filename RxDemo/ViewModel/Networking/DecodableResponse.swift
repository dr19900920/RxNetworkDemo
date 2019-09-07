import Foundation

enum DecodableResponse<Data: Decodable>: Decodable {
    typealias Message = APIResponseMessage
    
    case success(Message, Data)
    case failure(Message)
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        
        let svc = try decoder.singleValueContainer()
        let message = try svc.decode(Message.self)
        
        if message.code == 10001 {
            let data = try c.decode(Data.self, forKey: .data)
            
            self = .success(message, data)
        } else {
            self = .failure(message)
        }
    }
}
