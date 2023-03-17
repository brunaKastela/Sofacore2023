import UIKit
import SnapKit

protocol TabItemViewDelegate: AnyObject {

    func tabItemViewTapped(_ tabIndex: Int)

}

class TabView: BaseView {

    private enum Constants {
        static let selectorBarWidth: CGFloat = 104
        static let animationDuration = 0.25
    }

    weak var delegate: TabItemViewDelegate?

    private let tabStackView = UIStackView()
    private let footballTabView = TabItemView(with: TabModel(image: .footballIcon, title: .localized(.football)))
    private let basketBallTabView = TabItemView(with: TabModel(image: .basketballIcon, title: .localized(.basketball)))
    private let amFootballTabView = TabItemView(with: TabModel(image: .amFootballIcon, title: .localized(.amFootball)))
    private let selectorBarView = UIView()
    private let selectorBar = UIView()

    override func addViews() {
        addSubview(tabStackView)
        tabStackView.addArrangedSubviews([footballTabView, basketBallTabView, amFootballTabView])

        addSubview(selectorBarView)

        selectorBarView.addSubview(selectorBar)
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
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.width.equalTo(Constants.selectorBarWidth)
            make.height.equalTo(4)
        }
    }

    override func setupGestureRecognizers() {
        tabStackView.arrangedSubviews.forEach {
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
        }
    }

    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        guard
            let tappedView = sender.view,
            let index = tabStackView.arrangedSubviews.firstIndex(of: tappedView)
        else { return }

        delegate?.tabItemViewTapped(index)
    }

    func updateBarPosition(index: Int) {
        let tabItemWidth = UIScreen.main.bounds.width / CGFloat(tabStackView.arrangedSubviews.count)
        let selectorPosition = CGFloat(index) * tabItemWidth + (tabItemWidth - Constants.selectorBarWidth) / 2

        UIView.animate(withDuration: Constants.animationDuration) {
            self.selectorBar.transform = CGAffineTransform(translationX: selectorPosition, y: 0)
        }
    }

}
