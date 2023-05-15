import UIKit

class EventsViewController: UIViewController {

    private var eventSections: [EventSection] = []
    private let eventViewModel = EventViewModel()

    private let tableView = UITableView()

    private let slug = "football"

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: Date())

        eventViewModel.getEvents(for: slug, for: formattedDate) { [weak self] in
            self?.eventViewModel.prepareEvents()
            self?.tableView.reloadData()
        }

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
        tableView.register(TournamentHeaderView.self, forHeaderFooterViewReuseIdentifier: TournamentHeaderView.identifier)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none

        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 0
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TournamentHeaderView.identifier) as? TournamentHeaderView else {
            return nil
        }
        eventViewModel.configureHeader(of: headerView, with: eventViewModel.eventSections[section].tournament)
        return headerView
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        eventViewModel.eventSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventViewModel.eventSections[section].events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
            return UITableViewCell()
        }

//        if index >= 0 && index < eventViewModel.count {
//                   eventViewModel.configure(of: cell, with: eventViewModel.eventSections[indexPath.section].events[indexPath.row])
//               }
        eventViewModel.configure(of: cell, with: eventViewModel.eventSections[indexPath.section].events[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
}
