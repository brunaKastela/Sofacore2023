import UIKit

class DatePickerViewCell: UICollectionViewCell {

    let stackView = UIStackView()

    let dayLabel = UILabel()
    let dateLabel = UILabel()

    let selectorBar = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: DatePickerModel) {
        dayLabel.text = model.dayOfWeek
        dateLabel.text = model.dayAndMonth
        selectorBar.isHidden = true
    }

    func showBar() {
        selectorBar.isHidden = false
    }

    func hideBar() {
        selectorBar.isHidden = true
    }

}

extension DatePickerViewCell: BaseViewProtocol {

    func addViews() {
        contentView.addSubview(stackView)

        stackView.addArrangedSubviews([dayLabel, dateLabel])

        addSubview(selectorBar)
    }

    func styleViews() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center

        backgroundColor = .colorPrimaryVariant

        dayLabel.font = .micro
        dayLabel.textColor = .surfaceSurface1

        dateLabel.font = .micro
        dateLabel.textColor = .surfaceSurface1

        selectorBar.backgroundColor = .surfaceSurface1
        selectorBar.layer.cornerRadius = 3
        selectorBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        selectorBar.isHidden = true
    }

    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(10)
        }

        selectorBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(0)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(4)
        }
    }

}
