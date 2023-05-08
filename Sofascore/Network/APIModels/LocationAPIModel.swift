struct LocationAPIModel: Codable {

    let name: String
    let region: String
    let country: String
    let latitude: Float
    let longitude: Float
    let timeZoneId: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name
        case region
        case country
        case latitude = "lat"
        case longitude = "lon"
        case timeZoneId = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
    
}
