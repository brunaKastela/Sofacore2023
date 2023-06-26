import UIKit

class EventDetailsView: BaseView {

    private var homeTeamView = LargeTeamView()
    private var awayTeamView = LargeTeamView()

    private var dateTimeStack = UIStackView()
    private var dateLabel = UILabel()
    private var timeLabel = UILabel()

    private var scoreMinuteStack = UIStackView()
    private var scoreLabel = UILabel()
    private var minuteLabel = UILabel()

    private enum Constants {

        static let finishedGameLabel = "Full Time"

    }

    func configure(with eventModel: EventCellModel, for date: String) {
        if let eventModel = eventModel as? EventCellModel {
            homeTeamView.configure(with: eventModel.homeTeam)
            awayTeamView.configure(with: eventModel.awayTeam)

            dateLabel.text = date
            timeLabel.text = eventModel.startTime

            scoreLabel.text = "\(eventModel.homeTeam.teamScore) - \(eventModel.awayTeam.teamScore)"
            scoreLabel.textColor = eventModel.eventStatusColor

            minuteLabel.text = eventModel.eventStatus
            minuteLabel.textColor = eventModel.eventStatusColor

            switch eventModel.eventStatus {
            case EventViewModel.Constants.upcomingGameLabel:
                scoreMinuteStack.isHidden = true
            case EventViewModel.Constants.finishedGameLabel:
                dateTimeStack.isHidden = true
                minuteLabel.text = Constants.finishedGameLabel
            default:
                dateTimeStack.isHidden = true
            }
        }
    }

    override func addViews() {
        addSubview(homeTeamView)
        addSubview(awayTeamView)

        addSubview(dateTimeStack)
        dateTimeStack.addArrangedSubviews([dateLabel, timeLabel])

        addSubview(scoreMinuteStack)
        scoreMinuteStack.addArrangedSubviews([scoreLabel, minuteLabel])
    }

    override func styleViews() {
        dateTimeStack.axis = .vertical
        dateTimeStack.alignment = .center
        dateTimeStack.distribution = .fillEqually
        dateTimeStack.spacing = 4

        dateLabel.textColor(.onSurfaceOnSurfaceLv1)
        dateLabel.font = .micro
        dateLabel.textAlignment = .center
        dateLabel.lineBreakMode = .byTruncatingTail

        timeLabel.textColor(.onSurfaceOnSurfaceLv1)
        timeLabel.font = .micro
        timeLabel.textAlignment = .center
        timeLabel.lineBreakMode = .byTruncatingTail

        scoreMinuteStack.axis = .vertical
        scoreMinuteStack.alignment = .center
        scoreMinuteStack.distribution = .fill
        scoreMinuteStack.spacing = 0

        scoreLabel.font = .headline1Desktop
        scoreLabel.textAlignment = .center
        scoreLabel.lineBreakMode = .byTruncatingTail

        minuteLabel.font = .micro
        minuteLabel.textAlignment = .center
        minuteLabel.lineBreakMode = .byTruncatingTail
    }

    override func setupConstraints() {
        homeTeamView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(96)
        }

        awayTeamView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(96)
        }

        dateTimeStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(24)
        }

        scoreMinuteStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
    }

}

private class LargeTeamView: BaseView {

    private var teamStack = UIStackView()
    private var teamIcon = UIImageView()
    private var teamNameLabel = UILabel()

    func configure(with team: TeamModel) {
        if let team = team as? TeamModel {
            teamIcon.sd_setImage(with: team.teamIconUrl)
            teamNameLabel.text = team.teamName
        }
    }

    override func addViews() {
        addSubview(teamStack)
        teamStack.addArrangedSubviews([teamIcon, teamNameLabel])
    }

    override func styleViews() {
        teamStack.axis = .vertical
        teamStack.alignment = .center
        teamStack.distribution = .fillEqually
        teamStack.spacing = 8

        teamNameLabel.textColor(.onSurfaceOnSurfaceLv1)
        teamNameLabel.font = .assistive

        teamNameLabel.textAlignment = .center
        teamNameLabel.lineBreakMode = .byTruncatingTail
        teamNameLabel.numberOfLines = 2
    }

    override func setupConstraints() {
        teamStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        teamIcon.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }

}
