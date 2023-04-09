import UIKit
import SnapKit

class EventCell: UITableViewCell, Reusable {

    private let timeStack = UIStackView()
    private let startTimeLabel = UILabel()
    private let endTimeLabel = UILabel()

    private let dividerView = UIView()

    private let participantStack = UIStackView()

    private let homeTeamStack = UIStackView()
    private let homeTeamIcon = UIImageView()
    private let homeTeamLabel = UILabel()

    private let awayTeamStack = UIStackView()
    private let awayTeamIcon = UIImageView()
    private let awayTeamLabel = UILabel()

    private let scoreStack = UIStackView()
    private let homeTeamScore = UILabel()
    private let awayTeamScore = UILabel()

    private enum Constants {

        static let finishedGameLabel = "FT"
        static let upcomingGameLabel = "-"

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        startTimeLabel.text("")
        endTimeLabel.text("")

        homeTeamIcon.image = nil
        awayTeamIcon.image = nil

        homeTeamLabel.text("")
        awayTeamLabel.text("")

        homeTeamScore.text("")
        awayTeamScore.text("")
    }

}

extension EventCell: BaseViewProtocol {

    func addViews() {
        addSubview(timeStack)

        timeStack.addArrangedSubviews([startTimeLabel, endTimeLabel])

        addSubview(dividerView)

        addSubview(participantStack)

        participantStack.addArrangedSubviews([homeTeamStack, awayTeamStack])

        homeTeamStack.addArrangedSubviews([homeTeamIcon, homeTeamLabel])
        awayTeamStack.addArrangedSubviews([awayTeamIcon, awayTeamLabel])

        addSubview(scoreStack)

        scoreStack.addArrangedSubviews([homeTeamScore, awayTeamScore])
    }

    func styleViews() {
        timeStack.axis = .vertical
        timeStack.alignment = .center
        timeStack.distribution = .fillEqually
        timeStack.spacing = 4

        startTimeLabel.textColor(.onSurfaceOnSurfaceLv2).font(.micro)
        endTimeLabel.font(.micro)

        dividerView.backgroundColor(.onSurfaceOnSurfaceLv4)

        participantStack.axis = .vertical
        participantStack.alignment = .leading
        participantStack.distribution = .fill
        participantStack.spacing = 4

        homeTeamStack.axis = .horizontal
        homeTeamStack.alignment = .center
        homeTeamStack.distribution = .fill
        homeTeamStack.spacing = 8

        homeTeamLabel.font(.bodyParagraph)

        awayTeamStack.axis = .horizontal
        awayTeamStack.alignment = .center
        awayTeamStack.distribution = .fill
        awayTeamStack.spacing = 8

        awayTeamLabel.font(.bodyParagraph)

        scoreStack.axis = .vertical
        scoreStack.alignment = .center
        scoreStack.distribution = .fill
        scoreStack.spacing = 4

        homeTeamScore.font(.bodyParagraph)
        awayTeamScore.font(.bodyParagraph)
    }

    func setupConstraints() {
        timeStack.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(4)
            make.width.equalTo(56)
        }

        dividerView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.leading.equalTo(timeStack.snp.trailing).offset(3)
            make.verticalEdges.equalToSuperview().inset(8)
        }

        participantStack.snp.makeConstraints { make in
            make.leading.equalTo(dividerView.snp.trailing).offset(16)
            make.verticalEdges.equalToSuperview().inset(10)
        }

        homeTeamIcon.snp.makeConstraints { make in
            make.size.equalTo(16)
        }

        awayTeamIcon.snp.makeConstraints { make in
            make.size.equalTo(16)
        }

        scoreStack.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(participantStack.snp.trailing).offset(24)
            make.verticalEdges.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    func setupGestureRecognizers() {
        // Default implementation is empty
    }

}

extension EventCell {

    func configure(with model: Any) {
        guard let model = model as? EventModel else { return }

        configureEventCell(with: model)
    }

}

extension EventCell {

    func configureEventCell(with model: EventModel) {
        setProperties(of: model)

        if !model.hasStarted {
            setNotStarted()
        } else if let minutes = model.currentMinute {
            setLive(of: model, for: minutes)
        } else {
            setFinished(of: model)
        }
    }

    func setProperties(of model: EventModel) {
        startTimeLabel.text = model.formattedStartTime
        homeTeamLabel.text(model.homeTeam)
        awayTeamLabel.text(model.awayTeam)
        homeTeamIcon.image = model.homeTeamIcon
        awayTeamIcon.image = model.awayTeamIcon
    }

    func setLive(of model: EventModel, for minutes: Int) {
        setScore(of: model)

        endTimeLabel.text = "\(minutes)'"
        endTimeLabel.textColor(.specificLive)

        setHighlight(homeTeamLabel, homeTeamScore)
        setHighlight(awayTeamLabel, awayTeamScore)

        homeTeamScore.textColor(.specificLive)
        awayTeamScore.textColor(.specificLive)
    }

    func setNotStarted() {
        endTimeLabel.text(Constants.upcomingGameLabel).textColor(.onSurfaceOnSurfaceLv2)

        setHighlight(homeTeamLabel, homeTeamScore)
        setHighlight(awayTeamLabel, awayTeamScore)
    }

    func setFinished(of model: EventModel) {
        endTimeLabel.text(Constants.finishedGameLabel).textColor(.onSurfaceOnSurfaceLv2)

        setScore(of: model)

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

    func setScore(of model: EventModel) {
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
