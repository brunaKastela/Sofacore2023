import UIKit

struct IncidentSection {

    let period: PeriodCellModel
    let incidents: [IncidentCellModel]

}

struct PeriodCellModel {

    let text: String
    let textColor: UIColor

}

struct IncidentCellModel {

    let playerName: String
    let incidentIcon: UIImage
    let incidentIconTint: UIColor
    let time: String
    let score: String?
    let side: TeamSideEnum

}
