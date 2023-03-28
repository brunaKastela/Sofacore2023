import Foundation
struct ViewModel {

    let tabModel = [
        TabModel(image: .footballIcon, title: .localized(.football)),
        TabModel(image: .basketballIcon, title: .localized(.basketball)),
        TabModel(image: .amFootballIcon, title: .localized(.amFootball))]

//    game in progress model
    let eventModel1 = EventModel(
        startDate: Date(),
        startTime: DateComponents(hour: 11, minute: 00),
        currentMinute: 12,
        homeTeamIcon: .barcelonaIcon,
        homeTeam: "Barcelona",
        homeTeamScore: 1,
        awayTeamIcon: .realMadridIcon,
        awayTeam: "Real Madrid",
        awayTeamScore: 1
    )

//    finished game models
    let eventModel2 = EventModel(
        startDate: Date(),
        startTime: DateComponents(hour: 9, minute: 00),
        homeTeamIcon: .barcelonaIcon,
        homeTeam: "Barcelona",
        homeTeamScore: 1,
        awayTeamIcon: .realMadridIcon,
        awayTeam: "Real Madrid",
        awayTeamScore: 2
    )

    let eventModel3 = EventModel(
        startDate: Date(),
        startTime: DateComponents(hour: 08, minute: 00),
        homeTeamIcon: .barcelonaIcon,
        homeTeam: "Barcelona",
        homeTeamScore: 2,
        awayTeamIcon: .realMadridIcon,
        awayTeam: "Real Madrid",
        awayTeamScore: 1
    )

    let eventModel4 = EventModel(
        startDate: Date(),
        startTime: DateComponents(hour: 11, minute: 30),
        homeTeamIcon: .barcelonaIcon,
        homeTeam: "Barcelona",
        homeTeamScore: 2,
        awayTeamIcon: .realMadridIcon,
        awayTeam: "Real Madrid",
        awayTeamScore: 2
    )

//    game not started model
    let eventModel5 = EventModel(
        startDate: Date(),
        startTime: DateComponents(hour: 18, minute: 00),
        homeTeamIcon: .barcelonaIcon,
        homeTeam: "Barcelona",
        awayTeamIcon: .realMadridIcon,
        awayTeam: "Real Madrid"
    )
}
