import Foundation
import Alamofire
import RxSwift

public protocol ViewControllerNetworkingType {
    func request(name: String, type: Int) -> Observable<Version>
}

public struct ViewControllerNetworking: ViewControllerNetworkingType {
    private let networking = Environment.current.networking(ViewControllerAPI.self)
    
    public init() { }
    
    public func request(name: String, type: Int) -> Observable<Version> {
        return networking.requestData(.version(name: name, type: type))
            .asObservable()
            .decodeResponseData(Version.self)
    }
}
