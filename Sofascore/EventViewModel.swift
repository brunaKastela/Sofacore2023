import Foundation
import UIKit

class EventViewModel {

    var eventCellModels: [EventCellModel] = []
    var events: [Event] = []

    private let apiClient: APICient

    private enum Constants {

        static let finishedGameLabel = "FT"
        static let upcomingGameLabel = "-"

    }

    init() {
        self.apiClient = AlamofireAPIClient()
    }

    func getEvents(for slug: String, for date: String, completion: @escaping () -> Void) {
        apiClient.getEvents(for: slug, for: date) { [weak self] result, error in
            if let error = error {
                print(error)
            }

            if let result = result as? [Event] {
                self?.events = result.compactMap { $0 }
                self?.mapEvents()
                completion()
            }
        }
    }

    func mapEvents() {
        self.eventCellModels = events.map { event in
            let eventId = String(event.id)
            let teamsColors = getTeamsColor(for: event)
            let scoresColors = getScoresColor(for: event)

            let startTime = formatStartTime(of: event.startDate)
            let eventStatus = getStatus(for: event)
            let eventStatusColor = eventStatusColor(for: event.status)

            let homeTeamIconUrl = URL(string: "https://academy.dev.sofascore.com/team/\(event.homeTeam.id)/image")
            let homeTeamName = event.homeTeam.name
            let homeTeamScore = setScore(of: event.homeScore.total)

            let homeTeamNameColor = teamsColors.0
            let homeTeamScoreColor = scoresColors.0

            let homeTeam = TeamModel(
                teamIconUrl: homeTeamIconUrl,
                teamName: homeTeamName,
                teamScore: homeTeamScore,
                teamNameColor: homeTeamNameColor,
                teamScoreColor: homeTeamScoreColor)

            let awayTeamIconUrl = URL(string: "https://academy.dev.sofascore.com/team/\(event.awayTeam.id)/image")
            let awayTeamName = event.awayTeam.name
            let awayTeamScore = setScore(of: event.awayScore.total)

            let awayTeamColor = teamsColors.1
            let awayTeamScoreColor = scoresColors.1

            let awayTeam = TeamModel(
                teamIconUrl: awayTeamIconUrl,
                teamName: awayTeamName,
                teamScore: awayTeamScore,
                teamNameColor: awayTeamColor,
                teamScoreColor: awayTeamScoreColor)

            return EventCellModel(
                eventId: eventId,
                startTime: startTime,
                eventStatus: eventStatus,
                eventStatusColor: eventStatusColor,
                homeTeam: homeTeam,
                awayTeam: awayTeam)
        }
    }
}

extension EventViewModel {

    func configure(of cell: Any, with model: Any) {
        guard
            let model = model as? EventCellModel,
            let cell = cell as? EventCell
        else { return }

        cell.configureEventCell(with: model)
    }

    func setScore(of score: Int?) -> String {
        if let score = score {
            return String(score)
        }

        return ""
    }

    func formatStartTime(of dateString: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        guard let dateString else {
            return ""
        }
        let calendar = Calendar.current

        if let date = dateFormatter.date(from: dateString) {
            let hour = String(format: "%02d", calendar.component(.hour, from: date) )
            let minute = String(format: "%02d", calendar.component(.minute, from: date) )
            return "\(hour):\(minute)"
        } else {
            print("Could not parse date")
            return "--:--"
        }
    }

    private func getStatus(for event: Event) -> String {
        switch event.status {
        case .notstarted:
            return Constants.upcomingGameLabel
        case .inprogress:
            guard let minute = calculateCurrentMinute(for: event.startDate) else {
                return ""
            }
            return String(minute) + "'"
        case .finished:
            return Constants.finishedGameLabel
        }
    }

    private func calculateCurrentMinute(for startDate: String?) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        guard let startDate = startDate, let eventDate = dateFormatter.date(from: startDate) else {
            return nil
        }

        let currentDate = Date()
        let minutes = Int(currentDate.timeIntervalSince(eventDate) / 60)

        return minutes
    }

    private func eventStatusColor(for eventState: EventStates) -> UIColor {
        switch eventState {
        case .inprogress:
            return .specificLive
        case .finished, .notstarted:
            return .onSurfaceOnSurfaceLv2
        }
    }

    private func getTeamsColor(for event: Event) -> (UIColor, UIColor) {
        switch event.status {
        case .inprogress:
            return (.onSurfaceOnSurfaceLv1, .onSurfaceOnSurfaceLv1)
        case .finished:
            return getColorByScore(for: event)
        case .notstarted:
            return (.onSurfaceOnSurfaceLv1, .onSurfaceOnSurfaceLv1)
        default:
            return (.onSurfaceOnSurfaceLv2, .onSurfaceOnSurfaceLv2)
        }
    }

    private func getScoresColor(for event: Event) -> (UIColor, UIColor) {
        switch event.status {
        case .inprogress:
            return (.specificLive, .specificLive)
        case .finished:
            return getColorByScore(for: event)
        default:
            return (.onSurfaceOnSurfaceLv2, .onSurfaceOnSurfaceLv2)
        }
    }

    private func getColorByScore(for event: Event) -> (UIColor, UIColor) {
        switch (event.homeScore.total, event.awayScore.total) {
        case (let x?, let y?) where x == y:
            return (.onSurfaceOnSurfaceLv2, .onSurfaceOnSurfaceLv2)
        case (let x?, let y?) where x > y:
            return (.onSurfaceOnSurfaceLv1, .onSurfaceOnSurfaceLv2)
        case (let x?, let y?) where x < y:
            return (.onSurfaceOnSurfaceLv2, .onSurfaceOnSurfaceLv1)
        default:
            return (.onSurfaceOnSurfaceLv1, .onSurfaceOnSurfaceLv1)
        }
    }

}
