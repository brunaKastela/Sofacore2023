import Foundation
struct ViewModel {

    let tabModel = [
        TabModel(image: .footballIcon, title: .localized(.football)),
        TabModel(image: .basketballIcon, title: .localized(.basketball)),
        TabModel(image: .amFootballIcon, title: .localized(.amFootball))]

    let eventModel = [
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 11, minute: 00),
            currentMinute: 12,
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 1,
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid",
            awayTeamScore: 1
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 9, minute: 00),
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 1,
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid",
            awayTeamScore: 2
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 08, minute: 00),
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 2,
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid",
            awayTeamScore: 1
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 11, minute: 30),
            homeTeamIcon: .atlMadridIcon,
            homeTeam: "Atletico Madrid",
            homeTeamScore: 2,
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid",
            awayTeamScore: 2
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 18, minute: 00),
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid"
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 11, minute: 00),
            currentMinute: 67,
            homeTeamIcon: .atlMadridIcon,
            homeTeam: "Atletico Madrid",
            homeTeamScore: 3,
            awayTeamIcon: .realSociedadIcon,
            awayTeam: "Real Sociedad",
            awayTeamScore: 2
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 9, minute: 00),
            homeTeamIcon: .atlMadridIcon,
            homeTeam: "Atletico Madrid",
            homeTeamScore: 1,
            awayTeamIcon: .realSociedadIcon,
            awayTeam: "Real Sociedad",
            awayTeamScore: 2
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 08, minute: 00),
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 2,
            awayTeamIcon: .realSociedadIcon,
            awayTeam: "Real Sociedad",
            awayTeamScore: 1
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 11, minute: 30),
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 2,
            awayTeamIcon: .realSociedadIcon,
            awayTeam: "Real Sociedad",
            awayTeamScore: 2
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 18, minute: 00),
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid"
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 11, minute: 00),
            currentMinute: 12,
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 1,
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid",
            awayTeamScore: 1
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 9, minute: 00),
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 1,
            awayTeamIcon: .realSociedadIcon,
            awayTeam: "Real Sociedad",
            awayTeamScore: 2
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 08, minute: 00),
            homeTeamIcon: .atlMadridIcon,
            homeTeam: "Atletico Madrid",
            homeTeamScore: 2,
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid",
            awayTeamScore: 1
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 11, minute: 30),
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 2,
            awayTeamIcon: .realSociedadIcon,
            awayTeam: "Real Sociedad",
            awayTeamScore: 2
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 18, minute: 00),
            homeTeamIcon: .atlMadridIcon,
            homeTeam: "Atletico Madrid",
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid"
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 11, minute: 00),
            currentMinute: 12,
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 1,
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid",
            awayTeamScore: 1
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 9, minute: 00),
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 1,
            awayTeamIcon: .realSociedadIcon,
            awayTeam: "Real Sociedad",
            awayTeamScore: 2
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 08, minute: 00),
            homeTeamIcon: .atlMadridIcon,
            homeTeam: "Atletico Madrid",
            homeTeamScore: 2,
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid",
            awayTeamScore: 1
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 11, minute: 30),
            homeTeamIcon: .barcelonaIcon,
            homeTeam: "Barcelona",
            homeTeamScore: 2,
            awayTeamIcon: .realSociedadIcon,
            awayTeam: "Real Sociedad",
            awayTeamScore: 2
        ),
        EventModel(
            startDate: Date(),
            startTime: DateComponents(hour: 18, minute: 00),
            homeTeamIcon: .atlMadridIcon,
            homeTeam: "Atletico Madrid",
            awayTeamIcon: .realMadridIcon,
            awayTeam: "Real Madrid"
        )]

}
