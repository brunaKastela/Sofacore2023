import Foundation

protocol APICient {

    func getWeather(for city: String, with key: String, completion: @escaping (WeatherAPIModel?, Error?) -> Void)

}
