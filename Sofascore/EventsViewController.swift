import UIKit
import SnapKit

protocol EventSelectionDelegate: AnyObject {

    func didSelectEvent(_ tournament: Tournament,_ event: EventCellModel)

}

class EventsViewController: UIViewController {

    private var eventSections: [EventSection] = []
    private let eventViewModel = EventViewModel()

    private let backgroundView = UIView()
    private let dateHeaderView = DateHeaderView()
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    weak var delegate: EventSelectionDelegate?

    private let slug = "football"

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        setupConstraints()
        styleViews()
    }

    func reloadEvents(for date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)

        eventViewModel.getEvents(for: slug, for: formattedDate) { [weak self] in
            self?.eventViewModel.prepareEvents()

            self?.dateHeaderView.setView(
                for: self?.eventViewModel.getDateLabel(for: date),
                with: self?.eventViewModel.getEventNumberLabel())

            self?.tableView.reloadData()
        }
    }

}

extension EventsViewController: BaseViewProtocol {

    func addViews() {
        view.addSubview(dateHeaderView)
        view.addSubview(tableView)
    }

    func styleViews() {
        backgroundView.backgroundColor = .surfaceSurface0
        tableView.backgroundView = backgroundView

        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.register(TournamentHeaderView.self, forCellReuseIdentifier: TournamentHeaderView.identifier)
        tableView.register(DividerView.self, forHeaderFooterViewReuseIdentifier: DividerView.identifier)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none

        tableView.sectionFooterHeight = 1
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionHeaderHeight = 0

        tableView.tableHeaderView = dateHeaderView
    }

    func setupConstraints() {
        dateHeaderView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(48)
        }

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        eventViewModel.eventSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventViewModel.eventSections[section].events.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard
                let headerCell = tableView.dequeueReusableCell(withIdentifier: TournamentHeaderView.identifier
            ) as? TournamentHeaderView else {
                    return UITableViewCell()
            }

            eventViewModel.configureHeader(
                of: headerCell,
                with: eventViewModel.eventSections[indexPath.section].tournament)

            return headerCell
        } else {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath
            ) as? EventCell else {
                return UITableViewCell()
            }

            eventViewModel.configure(
                of: cell,
                with: eventViewModel.eventSections[indexPath.section].events[indexPath.row - 1])

            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section != eventViewModel.eventSections.count - 1 else { return nil }

        guard
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DividerView.identifier
        ) as? DividerView else {
            return nil
        }

        return footerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTournament = eventViewModel.eventSections[indexPath.section].tournament

        guard indexPath.row != 0 else { return }

        if let selectedEvent = eventViewModel.eventSections[indexPath.section].events[indexPath.row - 1]
            as? EventCellModel {
                delegate?.didSelectEvent(selectedTournament, selectedEvent)

        }
    }

}
