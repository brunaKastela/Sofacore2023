struct ConditionAPIModel: Codable {

    let description: String
    let iconUrl: String

    enum CodingKeys: String, CodingKey {
        case description = "text"
        case iconUrl = "icon"
    }

}
