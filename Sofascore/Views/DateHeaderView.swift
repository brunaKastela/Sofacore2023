import UIKit

class DateHeaderView: BaseView {

    let dateLabel = UILabel()
    let eventNumberLabel = UILabel()

    func setView(for date: String?, with eventNumber: String?) {
        if let date = date {
            dateLabel.text = date
        }
        if let eventNumber = eventNumber {
            eventNumberLabel.text = eventNumber
        }
    }

    override func addViews() {
        addSubview(dateLabel)
        addSubview(eventNumberLabel)
    }

    override func styleViews() {
        backgroundColor = .surfaceSurface0

        dateLabel.font = .systemFont(ofSize: 12, weight: .bold)
        dateLabel.textColor = .black

        eventNumberLabel.font = .systemFont(ofSize: 12, weight: .bold)
        eventNumberLabel.textColor = .onSurfaceOnSurfaceLv2
    }

    override func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.lessThanOrEqualTo(eventNumberLabel.snp.leading).offset(-16)
        }

        eventNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(16)
        }
    }

}
