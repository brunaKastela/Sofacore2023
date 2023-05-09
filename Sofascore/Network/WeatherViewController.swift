import UIKit
import Alamofire

class WeatherViewController: UIViewController {

    private let weatherViewModel: WeatherViewModel

    private let weatherView = WeatherView()

    private enum TestingConstants {

        static let city = "Zadar"
        static let key = "0ab9485b0f3e445da37212546230705"

    }

    init() {
        self.weatherViewModel = WeatherViewModel(for: TestingConstants.city, with: TestingConstants.key)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getWeather()

        addViews()
        styleViews()
        setupConstraints()
    }

    private func getWeather() {
        if let weatherViewConfigModel = weatherViewModel.weatherModel {
            weatherView.configure(with: weatherViewConfigModel)
        }
    }

}

extension WeatherViewController: BaseViewProtocol {

    func addViews() {
        view.addSubview(weatherView)
    }

    func styleViews() {
        view.backgroundColor = .colorPrimaryHighlight
    }

    func setupConstraints() {
        weatherView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

}
