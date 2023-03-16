import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let headerView = HeaderView()
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }

        let tabView = TabView()
        view.addSubview(tabView)
        tabView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        let containerView = UIView()
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(tabView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
 
