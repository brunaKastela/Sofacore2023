import UIKit

class WeatherViewModel {

    var weatherModel: WeatherViewConfigModel?

    private let apiClient: APICient

    init(for city: String, with key: String) {

        self.apiClient = AlamofireAPIClient()
        getWeatherModel(for: city, with: key)
    }

    func getWeatherModel(for city: String, with key: String) {
        apiClient.getWeather(for: city, with: key) { [weak self] result, error in
            if let error {
                print(error)
            }

            if let result {
                var temperature: String
                var wind: String

                if UserPreferences.usesMetricSystem {
                    temperature = String(format: "%.0f°C", result.currentWeather.temperatureC)
                    wind = "\(result.currentWeather.windKph) km/h"
                } else {
                    temperature = String(format: "%.0f°F", result.currentWeather.temperatureF)
                    wind = "\(result.currentWeather.windMph) m/h"
                }

                self?.weatherModel = WeatherViewConfigModel(
                    iconUrl: result.currentWeather.condition.iconUrl,
                    description: result.currentWeather.condition.description,
                    locationName: result.location.name,
                    country: result.location.country,
                    temperature: temperature,
                    wind: wind,
                    humidity: result.currentWeather.humidity,
                    uvIndex: result.currentWeather.uvIndex)
            }
        }
    }

}
