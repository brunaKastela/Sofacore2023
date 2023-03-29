import UIKit

class EventsViewController: UIViewController {

    private var eventModel = ViewModel().eventModel

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()
    }

}

extension EventsViewController: BaseViewProtocol {

    func addViews() {
        view.addSubview(tableView)
    }

    func styleViews() {
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension EventsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier) as? EventCell
        else {
            return UITableViewCell()
        }

        let index = indexPath.row

        if index >= 0 && index < eventModel.count {
            cell.configure(with: eventModel[indexPath.row])
        }

        return cell
    }

}
