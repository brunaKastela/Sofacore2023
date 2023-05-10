import UIKit

struct EventModel {

    let startDate: Date
    let startTime: DateComponents
    let eventState: EventStates

    let homeTeamIcon: UIImage
    let homeTeam: String
    var homeTeamScore: Int?

    let awayTeamIcon: UIImage
    let awayTeam: String
    var awayTeamScore: Int?

}

struct EventCellModel {

    let startTime: String
    let eventStatus: String
    let eventStatusColor: UIColor

    let homeTeam: TeamModel
    let awayTeam: TeamModel

}
