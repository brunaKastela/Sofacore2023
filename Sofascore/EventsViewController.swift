import UIKit

class EventsViewController: UIViewController {

    private let eventModel = ViewModel().eventModel

    // napraviti da prima model utakmica i radi polje eventova, za svaki radi vieq
    lazy var eventView = EventCell(with: eventModel)

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()
    }

}

extension EventsViewController: BaseViewProtocol {

    func addViews() {
        view.addSubview(eventView)
    }

    func styleViews() {
    }

    func setupConstraints() {
        eventView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
    }

}
