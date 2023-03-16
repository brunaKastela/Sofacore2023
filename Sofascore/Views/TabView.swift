import UIKit
import SnapKit

protocol TabItemViewDelegate: AnyObject {
    func tabItemViewTapped(_ tabIndex: Int)
}

final class TabView: BaseView {

    weak var delegate: TabItemViewDelegate?

    private let tabStackView = UIStackView()

    private let footballTabView = TabItemView(iconImage: .footballIcon, labelText: .localized(.football))
    private let basketBallTabView = TabItemView(iconImage: .basketballIcon, labelText: .localized(.basketball))
    private let amFootballTabView = TabItemView(iconImage: .amFootballIcon, labelText: .localized(.amFootball))

    private let selectorBarView = UIView()
    private let selectorBar = UIView()

    override func addViews() {
        tabStackView.addArrangedSubviews([footballTabView, basketBallTabView, amFootballTabView])

        addSubview(tabStackView)

        addSubview(selectorBarView)
        selectorBarView.addSubview(selectorBar)
        tabStackView.bringSubviewToFront(selectorBarView)
    }

    override func styleViews() {
        backgroundColor = .colorPrimaryDefault

        tabStackView.axis = .horizontal
        tabStackView.distribution = .fillEqually
        tabStackView.alignment = .center

        selectorBar.backgroundColor = .surfaceSurface1
        selectorBar.layer.cornerRadius = 3
        selectorBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func setupConstraints() {
        tabStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        selectorBarView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().inset(44)
            make.bottom.equalToSuperview().inset(0)
        }

        selectorBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(0)
            make.width.equalTo(104)
            make.height.equalTo(4)
        }
    }

    override func setupGestureRecognizers() {
        tabStackView.arrangedSubviews.forEach({
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTapView(_:))))
        })

    }

    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view,
              let index = tabStackView.arrangedSubviews.firstIndex(of: tappedView) else {
            return
        }
        print("Tapped index: \(index)")
        delegate?.tabItemViewTapped(index)

    }

}
