struct ViewModel {

    let tabModel = [
        TabModel(image: .footballIcon, title: .localized(.football)),
        TabModel(image: .basketballIcon, title: .localized(.basketball)),
        TabModel(image: .amFootballIcon, title: .localized(.amFootball))]

    let eventModel = EventModel(
        homeTeamIcon: .barcelonaIcon,
        homeTeam: "Barcelona",
        homeTeamScore: 1,
        awayTeamIcon: .realMadridIcon,
        awayTeam: "Real Madrid",
        awayTeamScore: 2
    )
}
