import UIKit
import SnapKit

class TabItemView: BaseView {

    private let model: TabModel

    private let sportView = UIStackView()
    private let sportImageView = UIImageView()
    private let sportLabelView = UILabel()

    init(with model: TabModel) {
        self.model = model

        super.init()
    }

    override func addViews() {
        addSubview(sportView)
        sportView.addArrangedSubviews([sportImageView, sportLabelView])
    }

    override func styleViews() {
        backgroundColor = .colorPrimaryDefault

        sportView.axis = .vertical
        sportView.alignment = .center
        sportView.distribution = .fillEqually
        sportView.spacing = 4

        sportImageView.image = model.image.withRenderingMode(.alwaysTemplate)
        sportImageView.tintColor(.surfaceSurface1)

        sportLabelView.text = model.title
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

}
