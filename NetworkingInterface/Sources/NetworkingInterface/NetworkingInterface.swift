import Core
import Domain
import Moya

public protocol NetworkingModuleInterface: Module {
    @discardableResult
    func getSearch(query: String, completion: @escaping ([Search]?, Error?) -> Void) -> Cancellable?
    @discardableResult
    func getForecast(query: String, days: Int, completion: @escaping (Forecast?, Error?) -> Void) -> Cancellable?
}
