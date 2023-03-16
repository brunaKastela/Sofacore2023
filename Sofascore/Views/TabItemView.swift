import UIKit
import SnapKit

final class TabItemView: BaseView {

    private let sportView = UIStackView()
    private let sportImageView = UIImageView()
    private let sportLabelView = UILabel()

    init(iconImage: UIImage, labelText: String) {
        super.init()
        configure(withImage: iconImage, labelText: labelText)
    }

    override func addViews() {
        sportView.addArrangedSubviews([sportImageView, sportLabelView])
        addSubview(sportView)
    }

    override func styleViews() {
        backgroundColor = .colorPrimaryDefault

        sportView.axis = .vertical
        sportView.alignment = .center
        sportView.distribution = .fillEqually
        sportView.spacing = 4

        sportImageView.tintColor(.surfaceSurface1)
        sportLabelView.textColor(.surfaceSurface1)
        sportLabelView.font = .tab
    }

    override func setupConstraints() {
        sportView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview()
        }

        sportImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
    }

    func configure(withImage image: UIImage, labelText: String) {
        sportImageView.image = image.withRenderingMode(.alwaysTemplate)
        sportLabelView.text = labelText
    }

}
