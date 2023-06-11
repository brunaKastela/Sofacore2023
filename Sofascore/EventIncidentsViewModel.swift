import Foundation
import UIKit

class EventIncidentsViewModel {

    var incidents: [IncidentModel] = []

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

}
