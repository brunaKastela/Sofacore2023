import Foundation
import UIKit

class EventViewModel {

    var eventCellModels: [EventCellModel] = []

    private enum Constants {

        static let finishedGameLabel = "FT"
        static let upcomingGameLabel = "-"

    }

    init() {
        fetchEvents()
    }

    private func fetchEvents() {
        let events = EventTestData.createEvents()

        eventCellModels = events.map { event in
            let teamsColors = getTeamsColor(for: event)
            let scoresColors = getScoresColor(for: event)

            let startTime = formatStartTime(with: event.startTime)
            let eventStatus = getStatus(for: event)
            let eventStatusColor = eventStatusColor(for: event.eventState)

            let homeTeamIcon = event.homeTeamIcon
            let homeTeamName = event.homeTeam
            let homeTeamScore = setScore(of: event.homeTeamScore)

            let homeTeamNameColor = teamsColors.0
            let homeTeamScoreColor = scoresColors.0

            let homeTeam = TeamModel(
                teamIcon: homeTeamIcon,
                teamName: homeTeamName,
                teamScore: homeTeamScore,
                teamNameColor: homeTeamNameColor,
                teamScoreColor: homeTeamScoreColor)

            let awayTeamIcon = event.awayTeamIcon
            let awayTeamName = event.awayTeam
            let awayTeamScore = setScore(of: event.awayTeamScore)

            let awayTeamColor = teamsColors.1
            let awayTeamScoreColor = scoresColors.1

            let awayTeam = TeamModel(
                teamIcon: awayTeamIcon,
                teamName: awayTeamName,
                teamScore: awayTeamScore,
                teamNameColor: awayTeamColor,
                teamScoreColor: awayTeamScoreColor)

            return EventCellModel(startTime: startTime,
                                  eventStatus: eventStatus,
                                  eventStatusColor: eventStatusColor,
                                  homeTeam: homeTeam,
                                  awayTeam: awayTeam)
        }
    }

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

    func formatStartTime(with dateComponents: DateComponents) -> String {
        let hour = String(format: "%02d", dateComponents.hour ?? 0)
        let minute = String(format: "%02d", dateComponents.minute ?? 0)

        return "\(hour):\(minute)"
    }

    private func getStatus(for event: EventModel) -> String {
        switch event.eventState {
        case .upcoming:
            return Constants.upcomingGameLabel
        case .inProgress:
            if let minute = calculateCurrentMinute(of: event) {
                return String(minute) + "'"
            }
            return ""
        case .finished:
            return Constants.finishedGameLabel
        }
    }

    private func calculateCurrentMinute(of eventModel: EventModel) -> Int? {
        guard eventModel.eventState == EventStates.inProgress else {
            return nil
        }

        let date = Date()
        let calendar = Calendar.current

        guard
            let eventDateTime = calendar.date(byAdding: eventModel.startTime, to: eventModel.startDate)
        else {
            return 0
        }

        let diffComponents = Calendar.current.dateComponents([.minute], from: eventDateTime, to: date)
        let minutes = diffComponents.minute

        return minutes
    }

    private func eventStatusColor(for eventState: EventStates) -> UIColor {
        switch eventState {
        case .inProgress:
            return .specificLive
        case .finished, .upcoming:
            return .onSurfaceOnSurfaceLv2
        }
    }

    private func getTeamsColor(for event: EventModel) -> (UIColor, UIColor) {
        switch event.eventState {
        case .inProgress:
            return (.onSurfaceOnSurfaceLv1, .onSurfaceOnSurfaceLv1)
        case .finished:
            return getColorByScore(for: event)
        case .upcoming:
            return (.onSurfaceOnSurfaceLv1, .onSurfaceOnSurfaceLv1)
        default:
            return (.onSurfaceOnSurfaceLv2, .onSurfaceOnSurfaceLv2)
        }
    }

    private func getScoresColor(for event: EventModel) -> (UIColor, UIColor) {
        switch event.eventState {
        case .inProgress:
            return (.specificLive, .specificLive)
        case .finished:
            return getColorByScore(for: event)
        default:
            return (.onSurfaceOnSurfaceLv2, .onSurfaceOnSurfaceLv2)
        }
    }

    private func getColorByScore(for event: EventModel) -> (UIColor, UIColor) {
        switch (event.homeTeamScore, event.awayTeamScore) {
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
