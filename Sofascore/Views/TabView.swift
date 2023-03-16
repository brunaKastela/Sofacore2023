import UIKit
import SnapKit

final class TabView: BaseView {

    private let tabStackView = UIStackView()

    private let footballTabView = TabItemView(iconImage: .footballIcon, labelText: .localized(.football))
    private let basketBallTabView = TabItemView(iconImage: .basketballIcon, labelText: .localized(.basketball))
    private let amFootballTabView = TabItemView(iconImage: .amFootballIcon, labelText: .localized(.amFootball))

    override func addViews() {
        tabStackView.addArrangedSubviews([footballTabView, basketBallTabView, amFootballTabView])
        addSubview(tabStackView)
    }

    override func styleViews() {
        backgroundColor = .colorPrimaryDefault

        tabStackView.axis = .horizontal
        tabStackView.distribution = .fillEqually
        tabStackView.alignment = .center
    }

    override func setupConstraints() {
        tabStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func setupGestureRecognizers() {
    }
}
