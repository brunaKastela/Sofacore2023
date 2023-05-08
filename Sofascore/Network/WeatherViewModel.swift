import UIKit

class WeatherViewModel {

    var weatherModel: WeatherViewConfigModel?

    private let apiClient: APICient

    init() {
        self.apiClient = AlamofireAPIClient()
        getWeatherModel()
    }

    func getWeatherModel() {
        apiClient.getWeather { [weak self] result, error in
            if let error {
                print(error)
            }

            if let result {
                self?.weatherModel = WeatherViewConfigModel(
                    iconUrl: result.currentWeather.condition.iconUrl,
                    description: result.currentWeather.condition.description,
                    locationName: result.location.name,
                    country: result.location.country,
                    temperatureC: result.currentWeather.temperatureC,
                    windKph: result.currentWeather.windKph,
                    humidity: result.currentWeather.humidity,
                    uvIndex: result.currentWeather.uvIndex)
            }
        }
    }

}
