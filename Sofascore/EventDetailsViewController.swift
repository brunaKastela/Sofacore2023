import UIKit

class EventDetailsViewController: UIViewController {

    let eventDetailsViewModel = EventIncidentsViewModel()

    private let navigationView = NavigationHeaderView()
    private let eventDetailsView = EventDetailsView()
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    var tournament: Tournament?
    var event: EventCellModel?
    var date: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()

        navigationView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationHeader()
    }

    private func configureNavigationHeader() {
        navigationController?.setNavigationBarHidden(true, animated: false)

        if let tournament = tournament as? Tournament {
            navigationView.configure(for: tournament)
        }

        if let event = event as? EventCellModel, let date = date as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let formattedDate = dateFormatter.string(from: date)

            eventDetailsView.configure(with: event, for: formattedDate)
            loadEventIncidents(for: event.eventId, at: date)
        }
    }

    func loadEventIncidents(for id: Int, at date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)

        eventDetailsViewModel.getIncidents(for: id) { [weak self] in
            self?.eventDetailsViewModel.prepareEventIncidents()
            self?.tableView.reloadData()
        }
    }

}

extension EventDetailsViewController: BaseViewProtocol {

    func styleViews() {
        view.backgroundColor = .surfaceSurface1

        tableView.register(PeriodCell.self, forCellReuseIdentifier: PeriodCell.identifier)
        tableView.register(IncidentCell.self, forCellReuseIdentifier: IncidentCell.identifier)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none

        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionHeaderHeight = 0
    }

    func addViews() {
        view.addSubview(navigationView)
        view.addSubview(eventDetailsView)
        view.addSubview(tableView)
    }

    func setupConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.horizontalEdges.equalToSuperview().inset(12)
        }

        eventDetailsView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview().inset(16)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(eventDetailsView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

extension EventDetailsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        eventDetailsViewModel.incidentSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventDetailsViewModel.incidentSections[section].incidents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard
                let periodCell = tableView.dequeueReusableCell(withIdentifier: PeriodCell.identifier
            ) as? PeriodCell else {
                    return UITableViewCell()
            }

            eventDetailsViewModel.configurePeriodCell(
                of: periodCell,
                with: eventDetailsViewModel.incidentSections[indexPath.section].period)
            return periodCell
        } else {
            guard
                let incidentCell = tableView.dequeueReusableCell(withIdentifier: IncidentCell.identifier
            ) as? IncidentCell else {
                return UITableViewCell()
            }

            eventDetailsViewModel.configureIncidentCell(
                of: incidentCell,
                with: eventDetailsViewModel.incidentSections[indexPath.section].incidents[indexPath.row])
            return incidentCell
        }
    }

}


extension EventDetailsViewController: NavigationHeaderDelegate {

    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}
