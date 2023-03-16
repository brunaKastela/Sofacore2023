import UIKit

class ViewController: UIViewController, TabItemViewDelegate {

    let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }

    private func setUpView() {

        let headerView = HeaderView()
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        let tabView = TabView()
        view.addSubview(tabView)
        tabView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        tabView.delegate = self

        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(tabView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    func tabItemViewTapped(_ tabIndex: Int) {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        children.forEach { $0.removeFromParent() }

        let firstViewController = UIViewController()
        firstViewController.view.backgroundColor(.green)

        let secondViewController = UIViewController()
        secondViewController.view.backgroundColor(.red)

        let thirdViewController = UIViewController()
        thirdViewController.view.backgroundColor(.blue)

        let viewArray = [firstViewController, secondViewController, thirdViewController]

        containerView.addSubview(viewArray[tabIndex].view)
        addChild(viewArray[tabIndex])
        viewArray[tabIndex].didMove(toParent: self)

        viewArray[tabIndex].view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        print(children)
    }

}
