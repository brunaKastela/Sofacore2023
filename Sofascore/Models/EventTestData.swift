import Foundation

struct EventTestData {

    static func createEvents() -> [EventModel] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        let currentMinute = calendar.component(.minute, from: currentDate)

        var eventModels: [EventModel] = []

        let earlyStartTime = DateComponents(hour: currentHour - 2, minute: currentMinute)
        let earlyStartDate = calendar.startOfDay(for: currentDate)
        let earlyEvent = EventModel(
            startDate: earlyStartDate,
            startTime: earlyStartTime,
            eventState: .finished,
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 2,
            awayTeamIcon: .atlMadridIcon,
            awayTeam: "Atletico Madrid",
            awayTeamScore: 1)
        eventModels.append(earlyEvent)

        let earlyEvent2 = EventModel(
            startDate: earlyStartDate,
            startTime: earlyStartTime,
            eventState: .finished,
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 2,
            awayTeamIcon: .atlMadridIcon,
            awayTeam: "Atletico Madrid",
            awayTeamScore: 2)
        eventModels.append(earlyEvent2)

        let earlyEvent3 = EventModel(
            startDate: earlyStartDate,
            startTime: earlyStartTime,
            eventState: .finished,
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona title title title title title title title title title title",
            homeTeamScore: 1,
            awayTeamIcon: .atlMadridIcon,
            awayTeam: "Atletico Madrid",
            awayTeamScore: 2)
        eventModels.append(earlyEvent3)

        let currentStartTime = DateComponents(hour: currentHour, minute: 0)
        let currentStartDate = calendar.startOfDay(for: currentDate)
        let currentEvent = EventModel(
            startDate: currentStartDate,
            startTime: currentStartTime,
            eventState: .inprogress,
            homeTeamIcon: .realMadridIcon,
            homeTeam: "Real Madrid",
            homeTeamScore: 1,
            awayTeamIcon: .realSociedadIcon,
            awayTeam: "Real Sociedad",
            awayTeamScore: 2)
        eventModels.append(currentEvent)

        let lateStartTime = DateComponents(hour: currentHour + 2, minute: currentMinute)
        let lateStartDate = calendar.startOfDay(for: currentDate)
        let lateEvent = EventModel(
            startDate: lateStartDate,
            startTime: lateStartTime,
            eventState: .notstarted,
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: nil,
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid",
            awayTeamScore: nil)
        eventModels.append(lateEvent)

        return Array(repeating: eventModels, count: 3).flatMap { $0 }
    }

}
