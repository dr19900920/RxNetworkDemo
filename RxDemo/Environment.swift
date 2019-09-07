import Foundation

public final class Environment {
    public static let current: Environment = Environment()
    
    public func networking<API: BaseAPI>(_ api: API.Type) -> Netwoking<API> {
        return Netwoking<API>.new()
    }
}
