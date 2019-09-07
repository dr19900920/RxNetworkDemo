import Foundation
import RxSwift

extension ObservableType where Element == Data {
    private func _decodeResponseData<T: Decodable>(_ type: T.Type, decoder: JSONDecoder = .init()) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            do {
                let response = try decoder.decode(DecodableResponse<T>.self, from: data)
                switch response {
                case let .success(_, data):
                    return Observable.just(data)
                    
                case let .failure(message):
                    return Observable.error(NetworkError.internal(message))
                }
            } catch {
                return Observable.error(NetworkError.buildinDecoding(error))
            }
        }
    }
    
    public func decodeResponseData<T: Decodable>(_ type: T.Type, rootKey: String? = nil, decoder: JSONDecoder = .init()) -> Observable<T> {
        guard rootKey.isNonempty else { return _decodeResponseData(type, decoder: decoder) }
        
        decoder.userInfo[.jsonDecoderRootKey] = rootKey
        return _decodeResponseData(RootKeyDecodable<T>.self, decoder: decoder).map { $0.base }
    }
}

private extension CodingUserInfoKey {
    static let jsonDecoderRootKey = CodingUserInfoKey(rawValue: "com.dj.jsonDecoderRootKey")!
}

private struct RootKeyDecodable<Base: Decodable>: Decodable {
    let base: Base
    
    init(from decoder: Decoder) throws {
        guard let rootKey = decoder.userInfo[.jsonDecoderRootKey] as? String else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [], debugDescription: "must set a root key to decode nested \(Base.self)")
            )
        }
        
        let c = try decoder.container(keyedBy: GenericCodingKey.self)
        self.base = try c.decode(Base.self, forKey: .init(name: rootKey))
    }
}
