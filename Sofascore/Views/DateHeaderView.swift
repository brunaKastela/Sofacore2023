import UIKit

class DateHeaderView: BaseView {

    let dateLabel = UILabel()
    let eventNumberLabel = UILabel()

    override func addViews() {
        addSubview(dateLabel)
        addSubview(eventNumberLabel)
    }

    override func styleViews() {
        backgroundColor = .surfaceSurface0

        dateLabel.text = "Wed, 14.12.2022"
        dateLabel.font = .systemFont(ofSize: 12, weight: .bold)
        dateLabel.textColor = .black

        eventNumberLabel.text = "5 Events"
        eventNumberLabel.font = .systemFont(ofSize: 12, weight: .bold)
        eventNumberLabel.textColor = .onSurfaceOnSurfaceLv2
    }

    override func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.lessThanOrEqualTo(eventNumberLabel.snp.trailing).offset(50)
        }

        eventNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(16)
        }
    }

}
