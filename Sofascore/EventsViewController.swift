import UIKit
import SnapKit

class EventsViewController: UIViewController {

    private var eventSections: [EventSection] = []
    private let eventViewModel = EventViewModel()

    private let backgroundView = UIView()
    private let dateHeaderView = DateHeaderView()
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)

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

            self?.dateHeaderView.setView(
                for: self?.eventViewModel.getDateLabel(for: Date()),
                with: self?.eventViewModel.getEventNumberLabel())
        }

        addViews()
        styleViews()
        setupConstraints()
    }

}

extension EventsViewController: BaseViewProtocol {

    func addViews() {
        view.addSubview(dateHeaderView)
        view.addSubview(backgroundView)
        view.addSubview(tableView)
    }

    func styleViews() {
        backgroundView.backgroundColor = .white
        tableView.backgroundView = backgroundView

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
        dateHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dateHeaderView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = eventViewModel.eventSections[indexPath.section].events[indexPath.row]

        let tmpVC = UIViewController()
        tmpVC.view?.backgroundColor = .white
        let tmpLabel = UILabel()
        tmpLabel.text(String(selectedEvent.eventId))

        tmpVC.view.addSubview(tmpLabel)
        tmpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        present(tmpVC, animated: true)
    }
}
