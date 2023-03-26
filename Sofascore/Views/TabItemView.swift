import UIKit
import SnapKit

class TabItemView: BaseView {

    private let model: TabModel

    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let labelView = UILabel()

    init(with model: TabModel) {
        self.model = model

        super.init()
    }

    override func addViews() {
        addSubview(stackView)
        stackView.addArrangedSubviews([imageView, labelView])
    }

    override func styleViews() {
        backgroundColor = .colorPrimaryDefault

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 4

        imageView.image = model.image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor(.surfaceSurface1)

        labelView.text = model.title
        labelView.textColor(.surfaceSurface1)
        labelView.font = .tab
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
    }

}
