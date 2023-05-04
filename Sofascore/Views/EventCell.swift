import UIKit
import SnapKit

class EventCell: UITableViewCell, Reusable {

    private let timeStack = UIStackView()
    private let startTimeLabel = UILabel()
    private let eventStatusLabel = UILabel()

    private let dividerView = UIView()

    private let participantStack = UIStackView()

    private let homeTeamView = TeamView()
    private let awayTeamView = TeamView()

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
        eventStatusLabel.text("")

        homeTeamView.teamIcon.image = nil
        awayTeamView.teamIcon.image = nil

        homeTeamView.teamLabel.text = ""
        awayTeamView.teamLabel.text = ""

        homeTeamView.teamScoreLabel.text("")
        homeTeamView.teamScoreLabel.text("")
    }

}

extension EventCell: BaseViewProtocol {

    func addViews() {
        addSubview(timeStack)

        timeStack.addArrangedSubviews([startTimeLabel, eventStatusLabel])

        addSubview(dividerView)

        addSubview(participantStack)

        participantStack.addArrangedSubviews([homeTeamView, awayTeamView])
    }

    func styleViews() {
        timeStack.axis = .vertical
        timeStack.alignment = .center
        timeStack.distribution = .fillEqually
        timeStack.spacing = 4

        startTimeLabel.textColor(.onSurfaceOnSurfaceLv2).font(.micro)
        eventStatusLabel.font(.micro)

        dividerView.backgroundColor(.onSurfaceOnSurfaceLv4)

        participantStack.axis = .vertical
        participantStack.distribution = .fill
        participantStack.spacing = 4
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
            make.trailing.equalToSuperview().inset(16)
        }
    }

    func setupGestureRecognizers() {
        // Default implementation is empty
    }

}

extension EventCell {

    func configureEventCell(with model: EventCellModel) {
        setProperties(with: model)
        setColors(with: model)
    }

    func setProperties(with model: EventCellModel) {
        startTimeLabel.text = model.startTime
        eventStatusLabel.text = model.eventStatus

        homeTeamView.teamIcon.image = model.homeTeam.teamIcon
        homeTeamView.teamLabel.text = model.homeTeam.teamName
        homeTeamView.teamScoreLabel.text = model.homeTeam.teamScore

        awayTeamView.teamIcon.image = model.awayTeam.teamIcon
        awayTeamView.teamLabel.text = model.awayTeam.teamName
        awayTeamView.teamScoreLabel.text = model.awayTeam.teamScore
    }

    func setColors(with model: EventCellModel) {
        eventStatusLabel.textColor = model.eventStatusColor

        homeTeamView.teamLabel.textColor = model.homeTeam.teamNameColor
        homeTeamView.teamScoreLabel.textColor = model.homeTeam.teamScoreColor

        awayTeamView.teamLabel.textColor = model.awayTeam.teamNameColor
        awayTeamView.teamScoreLabel.textColor = model.awayTeam.teamScoreColor
    }

}
