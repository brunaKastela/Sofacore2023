import UIKit
import SnapKit
import SDWebImage

class IncidentCell: UITableViewCell, Reusable {

    private let containerView = UIView()

    private let detailsStack = UIStackView()
    private let incidentIcon = UIImageView()
    private let minuteLabel = UILabel()

    private let dividerView = UIView()

    private let scoreLabel = UILabel()

    private let playerLabel = UILabel()

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

        incidentIcon.image = nil

        minuteLabel.text = ""
        playerLabel.text = ""
        scoreLabel.text = ""

        scoreLabel.snp.makeConstraints { make in
            make.width.equalTo(0)
        }
    }

}

extension IncidentCell: BaseViewProtocol {

    func addViews() {
        addSubview(containerView)

        containerView.addSubview(detailsStack)
        detailsStack.addArrangedSubviews([incidentIcon, minuteLabel])

        containerView.addSubview(dividerView)

        containerView.addSubview(scoreLabel)

        containerView.addSubview(playerLabel)
    }

    func styleViews() {
        backgroundColor = .surfaceSurface1

        detailsStack.axis = .vertical
        detailsStack.alignment = .center
        detailsStack.distribution = .fill

        dividerView.backgroundColor(.onSurfaceOnSurfaceLv4)

        minuteLabel.font = .tabular
        minuteLabel.textColor = .onSurfaceOnSurfaceLv2

        scoreLabel.font = .headline1
        scoreLabel.textAlignment = .center
        playerLabel.font = .body
    }

    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
        }

        detailsStack.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
        }

        incidentIcon.snp.makeConstraints { make in
            make.size.equalTo(24)
        }

        dividerView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.verticalEdges.equalToSuperview().inset(8)
        }

        scoreLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
        }

        playerLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
        }
    }

}

extension IncidentCell {

    func configureIncidentCell(with model: IncidentCellModel) {
        minuteLabel.text = model.time
        playerLabel.text = model.playerName

        incidentIcon.image = model.incidentIcon.withRenderingMode(.alwaysTemplate)
        incidentIcon.tintColor = model.incidentIconTint

        if model.score != nil {
            scoreLabel.text = model.score
            scoreLabel.snp.makeConstraints { make in
                make.width.equalTo(84)
            }
        }

        switch model.side {
        case .home:
            setHomeAlignment()
        case .away:
            setAwayAlignment()
        }
    }

    func setHomeAlignment() {
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }

        detailsStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
        }

        dividerView.snp.makeConstraints { make in
            make.leading.equalTo(detailsStack.snp.trailing).offset(15)
        }

        scoreLabel.snp.makeConstraints { make in
            make.leading.equalTo(dividerView.snp.trailing).offset(6)
        }

        playerLabel.snp.makeConstraints { make in
            make.leading.equalTo(scoreLabel.snp.trailing).offset(6)
            make.trailing.equalToSuperview()
        }
    }

    func setAwayAlignment() {
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
        }

        detailsStack.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
        }

        dividerView.snp.makeConstraints { make in
            make.trailing.equalTo(detailsStack.snp.leading).offset(-15)
        }

        scoreLabel.snp.makeConstraints { make in
            make.trailing.equalTo(dividerView.snp.leading).offset(-6)
        }

        playerLabel.snp.makeConstraints { make in
            make.trailing.equalTo(scoreLabel.snp.leading).offset(-6)
            make.leading.equalToSuperview()
        }
    }

}
