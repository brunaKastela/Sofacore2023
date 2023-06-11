import Foundation
import UIKit

class EventIncidentsViewModel {

    var incidents: [IncidentModel] = []
    var incidentSections: [IncidentSection] = []

    private let apiClient: APICient

    enum Constants {

        static let finishedGameLabel = "FT"
        static let upcomingGameLabel = "-"

    }

    init() {
        self.apiClient = AlamofireAPIClient()
    }

    func prepareEventIncidents() {
        print(incidents)
        sectionIncidents()
        print(incidentSections)
    }

    func getIncidents(for id: Int, completion: @escaping () -> Void) {
        apiClient.getIncidents(for: id) { [weak self] result, error in
            if let error = error {
                print(error)
            }

            if let result = result as? [BaseIncidentModel] {
                self?.mapEvents(of: result)
                completion()
            }
        }
    }

    func mapEvents(of result: [BaseIncidentModel]) {
        self.incidents = result.map { (incident: BaseIncidentModel) -> IncidentModel in
            switch incident.type {
            case .card:
                guard let player = incident.player,
                    let teamSide = incident.teamSide,
                    let color = incident.color else {
                return IncidentModel(id: incident.id, time: incident.time, type: incident.type)
                }
                return CardModel(id: incident.id,
                                 time: incident.time,
                                 type: incident.type,
                                 player: player,
                                 teamSide: teamSide,
                                 color: color )
            case .goal:
                guard let player = incident.player,
                    let scoringTeam = incident.scoringTeam,
                    let homeScore = incident.homeScore,
                    let awayScore = incident.awayScore,
                    let goalType = incident.goalType else {
                    return IncidentModel(id: incident.id, time: incident.time, type: incident.type)
                }
                return GoalModel(id: incident.id,
                                 time: incident.time,
                                 type: incident.type,
                                 player: player,
                                 scoringTeam: scoringTeam,
                                 homeScore: homeScore,
                                 awayScore: awayScore,
                                 goalType: goalType)
            case .period:
                guard let text = incident.text else {
                    return IncidentModel(id: incident.id, time: incident.time, type: incident.type)
                }
                return PeriodModel(text: text,
                                   id: incident.id,
                                   time: incident.time,
                                   type: incident.type)
                }
        }
    }

    func sectionIncidents() {
        var incidentCellModels: [IncidentCellModel] = []

        for incident in incidents {
            if let card = incident as? CardModel {
                let cardCellModel = getCardCellModel(for: card)
                incidentCellModels.append(cardCellModel)
            } else if let period = incident as? PeriodModel {
                let periodCellModel = getPeriodCellModel(for: period)
                self.incidentSections.append(IncidentSection(period: periodCellModel, incidents: incidentCellModels))
                incidentCellModels = []
            } else if let goal = incident as? GoalModel {
                let goalCellModel = getGoalCellModel(for: goal)
                incidentCellModels.append(goalCellModel)
            }
        }
    }

    func getPeriodCellModel(for incident: PeriodModel) -> PeriodCellModel {
        PeriodCellModel(text: incident.text, textColor: .black)
    }

    func getCardCellModel(for incident: CardModel) -> IncidentCellModel {
        IncidentCellModel(playerName: incident.player.name,
                          incidentIcon: .card,
                          incidentIconTint: .yellow,
                          time: String(incident.time),
                          score: nil)
    }

    func getGoalCellModel(for incident: GoalModel) -> IncidentCellModel {
        IncidentCellModel(playerName: incident.player.name,
                          incidentIcon: .footballIcon,
                          incidentIconTint: .green,
                          time: String(incident.time),
                          score: "\(incident.homeScore) - \(incident.awayScore)")
    }

    func configureIncidentCell(of cell: Any, with model: Any) {
        guard
            let model = model as? IncidentCellModel,
            let cell = cell as? IncidentCell
        else { return }

        cell.configureIncidentCell(with: model)
    }

    func configurePeriodCell(of cell: Any, with model: Any) {
        guard
            let model = model as? PeriodCellModel,
            let cell = cell as? PeriodCell
        else { return }

        cell.configurePeriodCell(with: model)
    }
}
