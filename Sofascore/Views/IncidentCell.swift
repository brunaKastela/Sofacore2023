import UIKit
import SnapKit
import SDWebImage

class IncidentCell: UITableViewCell, Reusable {

    private let detailsStack = UIStackView()
    private let incidentIcon = UIImageView()
    private let minuteLabel = UILabel()

    private let dividerView = UIView()

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
    }

}

extension IncidentCell: BaseViewProtocol {

    func addViews() {
        addSubview(detailsStack)
        detailsStack.addArrangedSubviews([incidentIcon, minuteLabel])

        addSubview(dividerView)

        addSubview(playerLabel)
    }

    func styleViews() {
        backgroundColor = .colorSecondaryHighlight
    }

    func setupConstraints() {
        detailsStack.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(4)
            make.width.equalTo(56)
        }

        dividerView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.leading.equalTo(detailsStack.snp.trailing).offset(3)
            make.verticalEdges.equalToSuperview().inset(8)
        }

        playerLabel.snp.makeConstraints { make in
            make.leading.equalTo(dividerView.snp.trailing)
            make.verticalEdges.equalToSuperview()
            make.trailing.greaterThanOrEqualToSuperview().inset(16)
        }
    }

}

extension IncidentCell {

    func configureIncidentCell(with model: IncidentCellModel) {
        incidentIcon.image = model.incidentIcon
        minuteLabel.text = model.time
        playerLabel.text = model.playerName

    }

}
