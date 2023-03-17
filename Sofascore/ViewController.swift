import UIKit

class ViewController: UIViewController {

    let headerView = HeaderView()
    let tabView = TabView()
    let containerView = UIView()

    let firstViewController = UIViewController()
    let secondViewController = UIViewController()
    let thirdViewController = UIViewController()

    lazy var viewControllers = [firstViewController, secondViewController, thirdViewController]

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()

        tabView.delegate = self
        tabItemViewTapped(UserPreferences.selectedIndex)
    }

}

extension ViewController: BaseViewProtocol {

    func addViews() {
        view.addSubview(headerView)
        view.addSubview(tabView)
        view.addSubview(containerView)
    }

    func styleViews() {
        firstViewController.view.backgroundColor(.green)

        secondViewController.view.backgroundColor(.red)

        thirdViewController.view.backgroundColor(.blue)
    }

    func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        tabView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(tabView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

}

extension ViewController: TabItemViewDelegate {

    func tabItemViewTapped(_ tabIndex: Int) {
        UserPreferences.selectedIndex = tabIndex
        let selectedViewController = viewControllers[UserPreferences.selectedIndex]

        containerView.subviews.forEach { $0.removeFromSuperview() }
        children.forEach { $0.removeFromParent() }

        let animation: CATransition = CATransition()
        animation.duration = 0.3
        animation.type = .push
        animation.subtype = .fromRight
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        selectedViewController.view.layer.add(animation, forKey: "viewControllerTransition")

        containerView.addSubview(selectedViewController.view)
        addChild(selectedViewController)
        selectedViewController.didMove(toParent: self)

        selectedViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tabView.updateBarPosition(index: UserPreferences.selectedIndex)
    }

}
