import UIKit
import SnapKit

protocol TabItemViewDelegate: AnyObject {

    func tabItemViewTapped(_ tabIndex: Int)

}

class TabView: BaseView {

    private enum Constants {

        static let selectorBarWidthPercentage = 0.86

        static let animationDuration = 0.25

    }

    lazy var selectorBarWidth: CGFloat = calculateBarWidth()
    weak var delegate: TabItemViewDelegate?

    private let tabStackView = UIStackView()
    private let tabModel: [TabModel]

    private let selectorBarView = UIView()
    private let selectorBar = UIView()

    init(with model: [TabModel]) {
        self.tabModel = model

        super.init()
    }

    override func addViews() {
        addSubview(tabStackView)
        for model in tabModel {
            tabStackView.addArrangedSubviews(TabItemView(with: model))
        }

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
            make.width.equalTo(selectorBarWidth)
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
        let selectorPosition = CGFloat(index) * tabItemWidth + (tabItemWidth - selectorBarWidth) / 2

        UIView.animate(withDuration: Constants.animationDuration) {
            self.selectorBar.transform = CGAffineTransform(translationX: selectorPosition, y: 0)
        }
    }

    func calculateBarWidth() -> CGFloat {
        let tabItemWidth = UIScreen.main.bounds.width / CGFloat(tabStackView.arrangedSubviews.count)

        return tabItemWidth * Constants.selectorBarWidthPercentage
    }

}
