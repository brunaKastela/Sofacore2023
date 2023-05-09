struct WeatherAPIModel: Codable {

    let location: LocationAPIModel
    let currentWeather: CurrentWeatherAPIModel

    enum CodingKeys: String, CodingKey {
        case location
        case currentWeather = "current"
    }

}
