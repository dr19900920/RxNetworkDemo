import Foundation
import Moya
import RxMoya
import RxSwift

public typealias Netwoking = MoyaProvider

extension Netwoking where Target: BaseAPI {
    public static func new() -> Netwoking<Target> {
        let endpointClosure: (Target) -> Endpoint = { target in
            Endpoint(
                url: target.urlString,
                sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                method: target.method,
                task: target.task,
                httpHeaderFields: nil
            )
        }
        return Netwoking(endpointClosure: endpointClosure, plugins: [NetworkLoggerPlugin(verbose: true)])
    }
}

extension Netwoking {
    public func requestData(_ api: Target) -> Single<Data> {
        return rx.request(api).map { $0.data }
    }
}
