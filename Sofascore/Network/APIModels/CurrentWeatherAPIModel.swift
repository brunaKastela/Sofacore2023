struct CurrentWeatherAPIModel: Codable {

    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let temperatureC: Float
    let temperatureF: Float
    let isDay: Int
    let condition: ConditionAPIModel
    let windMph: Float
    let windKph: Float
    let windDegree: Int
    let windDir: String
    let pressureMb: Float
    let pressureIn: Float
    let precipMm: Float
    let precipIn: Float
    let humidity: Int
    let cloud: Int
    let feelslikeC: Float
    let feelslikeF: Float
    let visKm: Float
    let visMiles: Float
    let uvIndex: Float
    let gustMph: Float
    let gustKph: Float

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case temperatureC = "temp_c"
        case temperatureF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity
        case cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case uvIndex = "uv"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
    
}
