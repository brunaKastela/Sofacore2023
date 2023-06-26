import UIKit
import SnapKit
import SDWebImage

class PeriodCell: UITableViewCell, Reusable {

    private let highlightView = UIView()
    private let periodLabel = UILabel()

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

        periodLabel.text("")
    }

}

extension PeriodCell: BaseViewProtocol {

    func addViews() {
        addSubview(highlightView)
        highlightView.addSubview(periodLabel)
    }

    func styleViews() {
        backgroundColor = .surfaceSurface1

        highlightView.backgroundColor = .colorSecondaryHighlight
        periodLabel.font = .assistive
        periodLabel.textAlignment = .center

        highlightView.layer.cornerRadius = 16
        highlightView.clipsToBounds = true
    }

    func setupConstraints() {
        highlightView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }

        periodLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }
    }

}

extension PeriodCell {

    func configurePeriodCell(with model: PeriodCellModel) {
        periodLabel.text = model.text
        periodLabel.textColor = model.textColor
    }

}
