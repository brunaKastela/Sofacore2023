import UIKit

class EventDetailsViewController: UIViewController {

    let eventDetailsViewModel = EventIncidentsViewModel()

    private let navigationView = NavigationHeaderView()
    private let eventDetailsView = EventDetailsView()

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
        }
    }

}

extension EventDetailsViewController: BaseViewProtocol {

    func styleViews() {
        view.backgroundColor = .surfaceSurface1
    }

    func addViews() {
        view.addSubview(navigationView)
        view.addSubview(eventDetailsView)
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
    }

}

extension EventDetailsViewController: NavigationHeaderDelegate {

    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}
