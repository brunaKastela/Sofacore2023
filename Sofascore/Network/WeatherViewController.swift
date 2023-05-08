import UIKit
import Alamofire

class WeatherViewController: UIViewController {

    private let weatherViewModel = WeatherViewModel()

    private let weatherView = WeatherView()

    init() {
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
    }

    func setupConstraints() {
        weatherView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
