class BaseIncidentModel: Codable {
    var id: Int
    var time: Int
    var type: IncidentTypeEnum

    var player: Player?
    var teamSide: TeamSideEnum?
    var color: CardColorEnum?

    var text: String?

    var scoringTeam: TeamSideEnum?
    var homeScore: Int?
    var awayScore: Int?
    var goalType: GoalTypeEnum?

    init(id: Int, time: Int, type: IncidentTypeEnum, player: Player? = nil, teamSide: TeamSideEnum? = nil, color: CardColorEnum? = nil, text: String? = nil, scoringTeam: TeamSideEnum? = nil, homeScore: Int? = nil, awayScore: Int? = nil, goalType: GoalTypeEnum? = nil) {
        self.id = id
        self.time = time
        self.type = type
        self.player = player
        self.teamSide = teamSide
        self.color = color
        self.text = text
        self.scoringTeam = scoringTeam
        self.homeScore = homeScore
        self.awayScore = awayScore
        self.goalType = goalType
    }

    enum CodingKeys: String, CodingKey {
        case id
        case time
        case type
        case player
        case teamSide
        case color
        case text
        case scoringTeam
        case homeScore
        case awayScore
        case goalType
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        time = try container.decode(Int.self, forKey: .time)
        type = try container.decode(IncidentTypeEnum.self, forKey: .type)
        player = try container.decodeIfPresent(Player.self, forKey: .player)
        teamSide = try container.decodeIfPresent(TeamSideEnum.self, forKey: .teamSide)
        color = try container.decodeIfPresent(CardColorEnum.self, forKey: .color)
        text = try container.decodeIfPresent(String.self, forKey: .text)
        scoringTeam = try container.decodeIfPresent(TeamSideEnum.self, forKey: .scoringTeam)
        homeScore = try container.decodeIfPresent(Int.self, forKey: .homeScore)
        awayScore = try container.decodeIfPresent(Int.self, forKey: .awayScore)
        goalType = try container.decodeIfPresent(GoalTypeEnum.self, forKey: .goalType)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(time, forKey: .time)
        try container.encode(type, forKey: .type)
        try container.encode(player, forKey: .player)
        try container.encode(teamSide, forKey: .teamSide)
        try container.encode(color, forKey: .color)
        try container.encode(text, forKey: .text)
        try container.encode(scoringTeam, forKey: .scoringTeam)
        try container.encode(homeScore, forKey: .homeScore)
        try container.encode(awayScore, forKey: .awayScore)
        try container.encode(goalType, forKey: .goalType)
    }

}

class IncidentModel {
    var id: Int
    var time: Int
    var type: IncidentTypeEnum

    init(id: Int, time: Int, type: IncidentTypeEnum) {
        self.id = id
        self.time = time
        self.type = type
    }
}

class CardModel: IncidentModel {
    var player: Player
    var teamSide: TeamSideEnum
    var color: CardColorEnum

    init(id: Int, time: Int, type: IncidentTypeEnum, player: Player, teamSide: TeamSideEnum, color: CardColorEnum) {
        self.player = player
        self.teamSide = teamSide
        self.color = color
        super.init(id: id, time: time, type: type)
    }
}

class PeriodModel: IncidentModel {
    var text: String

    init(text: String, id: Int, time: Int, type: IncidentTypeEnum) {
        self.text = text
        super.init(id: id, time: time, type: type)
    }

}

class GoalModel: IncidentModel {
    var player: Player
    var scoringTeam: TeamSideEnum
    var homeScore: Int
    var awayScore: Int
    var goalType: GoalTypeEnum

    init(id: Int, time: Int, type: IncidentTypeEnum, player: Player, scoringTeam: TeamSideEnum, homeScore: Int, awayScore: Int, goalType: GoalTypeEnum) {
        self.player = player
        self.scoringTeam = scoringTeam
        self.homeScore = homeScore
        self.awayScore = awayScore
        self.goalType = goalType
        super.init(id: id, time: time, type: type)
    }

}

struct Player: Codable {

    let id: Int
    let name: String
    let slug: String
    let country: Country
    let position: String
}

enum TeamSideEnum: String, Codable {

    case home
    case away

}

enum GoalTypeEnum: String, Codable {

    case regular
    case owngoal
    case penalty
    case onepoint
    case twopoint
    case threepoint
    case touchdown
    case safety
    case fieldgoal
    case extrapoint

}

enum IncidentTypeEnum: String, Codable {

    case card
    case goal
    case period

}

enum CardColorEnum: String, Codable {

    case yellow
    case yellowred
    case red

}
