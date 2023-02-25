import Moya

protocol Networkable {
    var service: MoyaProvider<Service> { get }
    @discardableResult
    func getSearch(query: String, completion: @escaping ([SearchResponse]?, Error?) -> Void) -> Cancellable
    
    @discardableResult
    func getForecast(query: String, days: Int, completion: @escaping (ForecastResponse?, Error?) -> Void) -> Cancellable
}
