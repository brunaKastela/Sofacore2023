import UIKit
import SnapKit

class EventCell: BaseView {

    private var model: EventModel

    private let timeView = UIStackView()
    private let startTimeLabel = UILabel()
    private let endTimeLabel = UILabel()

    private let dividerView = UIView()

    private let participantView = UIStackView()

    private let homeTeamView = UIStackView()
    private let homeTeamIcon = UIImageView()
    private let homeTeamLabel = UILabel()

    private let awayTeamView = UIStackView()
    private let awayTeamIcon = UIImageView()
    private let awayTeamLabel = UILabel()

    private let scoreView = UIStackView()
    private let homeTeamScore = UILabel()
    private let awayTeamScore = UILabel()

    private enum Constants {

        static let finishedGameLabel = "FT"

        static let upcomingGameLabel = "-"
    }

    init(with model: EventModel) {
        self.model = model

        super.init()
    }

    open override func addViews() {
        addSubview(timeView)

        timeView.addArrangedSubviews([startTimeLabel, endTimeLabel])

        addSubview(dividerView)

        addSubview(participantView)

        participantView.addArrangedSubviews([homeTeamView, awayTeamView])
        homeTeamView.addArrangedSubviews([homeTeamIcon, homeTeamLabel])
        awayTeamView.addArrangedSubviews([awayTeamIcon, awayTeamLabel])

        addSubview(scoreView)
        scoreView.addArrangedSubviews([homeTeamScore, awayTeamScore])
    }

    open override func styleViews() {
        timeView.axis = .vertical
        timeView.alignment = .center
        timeView.distribution = .fillEqually
        timeView.spacing = 4

        startTimeLabel.text = model.formattedStartTime()
        startTimeLabel.textColor(.onSurfaceOnSurfaceLv2).font(.micro)

        endTimeLabel.textColor(.onSurfaceOnSurfaceLv2).font(.micro)

        dividerView.backgroundColor(.onSurfaceOnSurfaceLv4)

        participantView.axis = .vertical
        participantView.alignment = .leading
        participantView.distribution = .fillEqually
        participantView.spacing = 4

        homeTeamView.axis = .horizontal
        homeTeamView.alignment = .center
        homeTeamView.distribution = .fill
        homeTeamView.spacing = 8

        homeTeamLabel.text(model.homeTeam).font(.bodyParagraph)
        homeTeamIcon.image = model.homeTeamIcon

        awayTeamView.axis = .horizontal
        awayTeamView.alignment = .center
        awayTeamView.distribution = .fill
        awayTeamView.spacing = 8

        awayTeamLabel.text(model.awayTeam).font(.bodyParagraph)
        awayTeamIcon.image = model.awayTeamIcon

        scoreView.axis = .vertical
        scoreView.alignment = .center
        scoreView.distribution = .fill
        scoreView.spacing = 4

        homeTeamScore.font(.bodyParagraph)
        awayTeamScore.font(.bodyParagraph)

        configureStyleByScore()
    }

    open override func setupConstraints() {
        timeView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(4)
            make.width.equalTo(56)
        }

        dividerView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.leading.equalTo(timeView.snp.trailing).offset(3)
            make.verticalEdges.equalToSuperview().inset(8)
        }

        participantView.snp.makeConstraints { make in
            make.leading.equalTo(dividerView.snp.trailing).offset(16)
            make.verticalEdges.equalToSuperview().inset(10)
        }

        homeTeamIcon.snp.makeConstraints { make in
            make.size.equalTo(16)
        }

        awayTeamIcon.snp.makeConstraints { make in
            make.size.equalTo(16)
        }

        scoreView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(participantView.snp.trailing).offset(24)
            make.verticalEdges.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    open override func setupGestureRecognizers() {
        // Default implementation is empty
    }

    func configureStyleByScore() {
        if !model.hasStarted() {
            setToStart()
        } else if let minutes = model.currentMinute {
            setLiveHighlight(for: minutes)
        } else {
            setFinished()
        }
    }

    func setLiveHighlight(for minutes: Int) {
        setScore()

        endTimeLabel.text = "\(minutes)'"
        endTimeLabel.textColor(.specificLive)

        setHighlight(homeTeamLabel, homeTeamScore)
        setHighlight(awayTeamLabel, awayTeamScore)

        homeTeamScore.textColor(.specificLive)
        awayTeamScore.textColor(.specificLive)
    }

    func setToStart() {
        endTimeLabel.text(Constants.upcomingGameLabel)

        setHighlight(homeTeamLabel, homeTeamScore)
        setHighlight(awayTeamLabel, awayTeamScore)
    }

    func setFinished() {
        endTimeLabel.text(Constants.finishedGameLabel)

        setScore()

        switch (model.homeTeamScore, model.awayTeamScore) {
        case (let x?, let y?) where x == y:
            removeHighlight(homeTeamLabel, homeTeamScore)
            removeHighlight(awayTeamLabel, awayTeamScore)
        case (let x?, let y?) where x > y:
            setHighlight(homeTeamLabel, homeTeamScore)
            removeHighlight(awayTeamLabel, awayTeamScore)
        case (let x?, let y?) where x < y:
            removeHighlight(homeTeamLabel, homeTeamScore)
            setHighlight(awayTeamLabel, awayTeamScore)
        default:
            setHighlight(homeTeamLabel, homeTeamScore)
            setHighlight(awayTeamLabel, awayTeamScore)
        }
    }

    func setScore() {
        if let home = model.homeTeamScore, let away = model.awayTeamScore {
            homeTeamScore.text = String(home)
            awayTeamScore.text = String(away)
        }
    }

    func setHighlight(_ label: UILabel, _ score: UILabel) {
        label.textColor(.onSurfaceOnSurfaceLv1)
        score.textColor(.onSurfaceOnSurfaceLv1)
    }

    func removeHighlight(_ label: UILabel, _ score: UILabel) {
        label.textColor(.onSurfaceOnSurfaceLv2)
        score.textColor(.onSurfaceOnSurfaceLv2)
    }

}
