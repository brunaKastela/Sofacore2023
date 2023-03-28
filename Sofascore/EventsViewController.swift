import UIKit

class EventsViewController: UIViewController {

    private let eventModel1 = ViewModel().eventModel1
    private let eventModel2 = ViewModel().eventModel2
    private let eventModel3 = ViewModel().eventModel3
    private let eventModel4 = ViewModel().eventModel4
    private let eventModel5 = ViewModel().eventModel5

    // napraviti da prima model utakmica i radi polje eventova, za svaki radi vieq
    lazy var eventView1 = EventCell(with: eventModel1)
    lazy var eventView2 = EventCell(with: eventModel2)
    lazy var eventView3 = EventCell(with: eventModel3)
    lazy var eventView4 = EventCell(with: eventModel4)
    lazy var eventView5 = EventCell(with: eventModel5)

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()
    }

}

extension EventsViewController: BaseViewProtocol {

    func addViews() {
        view.addSubview(eventView1)
        view.addSubview(eventView2)
        view.addSubview(eventView3)
        view.addSubview(eventView4)
        view.addSubview(eventView5)
    }

    func styleViews() {
    }

    func setupConstraints() {
        eventView1.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
        }
        eventView2.snp.makeConstraints { make in
            make.top.equalTo(eventView1.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        eventView3.snp.makeConstraints { make in
            make.top.equalTo(eventView2.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        eventView4.snp.makeConstraints { make in
            make.top.equalTo(eventView3.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        eventView5.snp.makeConstraints { make in
            make.top.equalTo(eventView4.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
    }

}
