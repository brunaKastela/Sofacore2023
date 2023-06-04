import UIKit

class ViewController: UIViewController {

    let tabModel = [
        TabModel(image: .footballIcon, title: .localized(.football)),
        TabModel(image: .basketballIcon, title: .localized(.basketball)),
        TabModel(image: .amFootballIcon, title: .localized(.amFootball))]

    let safeAreaView = UIView()
    let headerView = HeaderView()
    lazy var tabView = TabView(with: tabModel)
    let containerView = UIView()

    let datePickerViewController = DatePickerViewController(viewModel: DatePickerViewModel())

    let firstViewController = EventsViewController()
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

        if let date = UserPreferences.selectedDateIndex as? Date {
            selectDate(date)
        } else {
            selectDate(Date())
        }
    }

}

extension ViewController: BaseViewProtocol {

    func addViews() {
        view.addSubview(safeAreaView)
        view.addSubview(headerView)
        view.addSubview(tabView)
        view.addSubview(datePickerViewController.view)
        view.addSubview(containerView)
    }

    func styleViews() {
        safeAreaView.backgroundColor = headerView.backgroundColor

        datePickerViewController.delegate = self

        secondViewController.view.backgroundColor(.red)

        thirdViewController.view.backgroundColor(.green)
    }

    func setupConstraints() {
        safeAreaView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }

        tabView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        datePickerViewController.view.snp.makeConstraints { make in
            make.top.equalTo(tabView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(datePickerViewController.view.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

}

extension ViewController: TabItemViewDelegate {

    func tabItemViewTapped(_ tabIndex: Int) {
        guard tabIndex < viewControllers.count else {return}

        UserPreferences.selectedIndex = tabIndex
        let selectedViewController = viewControllers[UserPreferences.selectedIndex]

        removeChildren()

        addAnimation(selectedViewController)

        addChilViewController(selectedViewController)

        tabView.updateBarPosition(index: UserPreferences.selectedIndex)
    }

    func removeChildren() {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        children.forEach { $0.removeFromParent() }
    }

    func addAnimation(_ selectedViewController: UIViewController) {
        let animation: CATransition = CATransition()

        animation.duration = 0.3
        animation.type = .push
        animation.subtype = .fromRight
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)

        selectedViewController.view.layer.add(animation, forKey: "viewControllerTransition")
    }

    func addChilViewController(_ selectedViewController: UIViewController) {
        containerView.addSubview(selectedViewController.view)
        addChild(selectedViewController)
        selectedViewController.didMove(toParent: self)

        selectedViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension ViewController: DatePickerDelegate {

    func onDateSelected(_ date: Date) {
        firstViewController.reloadEvents(for: date)
        UserPreferences.selectedDateIndex = date
    }

    func selectDate(_ date: Date) {
        datePickerViewController.selectItem(withDate: date)
    }

}
