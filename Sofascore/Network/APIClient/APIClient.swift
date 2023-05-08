import Foundation

protocol APICient {

    func getWeather(completion: @escaping (WeatherAPIModel?, Error?) -> Void)

}
