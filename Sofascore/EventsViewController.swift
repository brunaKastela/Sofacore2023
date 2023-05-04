import UIKit

class EventsViewController: UIViewController {

    private let eventViewModel = EventViewModel()

    private let tableView = UITableView()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        eventViewModel.eventCellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier) as? EventCell
        else {
            return UITableViewCell()
        }

        let index = indexPath.row

        if index >= 0 && index < eventViewModel.eventCellModels.count {
            eventViewModel.configure(of: cell, with: eventViewModel.eventCellModels[indexPath.row])
        }

        return cell
    }

}
