import UIKit

struct EventModel {

    let startDate: Date
    let startTime: DateComponents
    var currentMinute: Int?

    let homeTeamIcon: UIImage
    let homeTeam: String
    var homeTeamScore: Int?

    let awayTeamIcon: UIImage
    let awayTeam: String
    var awayTeamScore: Int?

    func formattedStartTime() -> String? {
        if let hour = startTime.hour, let minute = startTime.minute {
            return String(hour) + ":" + String(format: "%02d", minute)
        } else {
            return nil
        }
    }

    func hasStarted() -> Bool {
        let now = Date()

        let startDateTime = Calendar.current.date(
            bySettingHour: startTime.hour ?? 0,
            minute: startTime.minute ?? 0,
            second: 0,
            of: startDate)
        ?? Date.distantPast

        return now >= startDateTime
    }

}
