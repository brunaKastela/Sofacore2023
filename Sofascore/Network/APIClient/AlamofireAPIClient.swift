import Foundation
import Alamofire

class AlamofireAPIClient: APICient {

    func getWeather(completion: @escaping (WeatherAPIModel?, Error?) -> Void) {

        AF
            .request("https://api.weatherapi.com/v1/current.json?key=0ab9485b0f3e445da37212546230705&q=Zadar&aqi=no")
            .responseDecodable { result in
                completion(result.value, result.error)
            }
    }

}
