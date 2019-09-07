import Foundation
import Action
import NSObject_Rx
import RxSwift

public protocol ViewControllerViewModelType {
    typealias CellModel = String
    
    var dataSource: Observable<[CellModel]> { get }
    var version: Observable<Version> { get }
    var refresh: Action<(String, Int), Version> { get }
    
    var loadMore: Action<(), Version> { get }
}

public class ViewControllerViewModel: NSObject, ViewControllerViewModelType {
    public typealias Networking = ViewControllerNetworkingType

    public let dataSource: Observable<[CellModel]>
    public let version: Observable<Version>
    public let refresh: Action<(String, Int), Version>
    public let loadMore: Action<(), Version>
    
    private let _version = PublishSubject<Version>()
    private let _dataSource = BehaviorSubject<[CellModel]>(value: [])
    
    public init(networking: Networking = ViewControllerNetworking()) {
        self.version = _version.asObservable()
        
        self.dataSource = _dataSource.asObservable()
        
        self.refresh = Action { networking.request(name: $0.0, type: $0.1) }
        
        self.loadMore = Action { Observable.just(Version(code: "123", updateURL: nil, needUpdate: true, description: nil)) }

        super.init()

        refresh.elements.subscribe(_version).disposed(by: rx.disposeBag)
        
        refresh.underlyingError.subscribe { print($0) }.disposed(by: rx.disposeBag)
        
        loadMore.elements.map { [$0.code] }.subscribe(_dataSource).disposed(by: rx.disposeBag)
    }
}
