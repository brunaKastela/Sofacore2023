import Foundation
import Alamofire

class AlamofireAPIClient: APICient {

    func getWeather(for city: String, with key: String, completion: @escaping (WeatherAPIModel?, Error?) -> Void) {

        AF
            .request("https://api.weatherapi.com/v1/current.json?key=\(key)&q=\(city)&aqi=no")
            .responseDecodable { result in
                completion(result.value, result.error)
            }
    }

}
