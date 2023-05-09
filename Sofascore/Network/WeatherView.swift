import Foundation
import UIKit
import SDWebImage

class WeatherView: BaseView {

    private let weatherStackView = UIStackView()

    private var iconImageView = UIImageView()

    private let descriptionLabel = UILabel()
    private let locationLabel = UILabel()
    private let countryLabel = UILabel()

    private let temperatureLabel = UILabel()
    private let windLabel = UILabel()
    private let humidityLabel = UILabel()
    private let uvIndexLabel = UILabel()

    override func addViews() {
        addSubview(weatherStackView)

        weatherStackView.addArrangedSubviews(
            [iconImageView,
             temperatureLabel,
             descriptionLabel,
             locationLabel,
             countryLabel,
             windLabel,
             humidityLabel,
             uvIndexLabel])
    }

    override func styleViews() {
        backgroundColor = .colorPrimaryHighlight

        weatherStackView.axis = .vertical
        weatherStackView.spacing = 16
        weatherStackView.alignment = .center
    }

    override func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
        }

        weatherStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }

    func configure(with model: WeatherViewConfigModel) {
        if let url = URL(string: "https:" + model.iconUrl) {
            iconImageView.sd_setImage(with: url)
        }

        temperatureLabel.text = model.temperature
        descriptionLabel.text = model.description
        locationLabel.text = model.locationName
        countryLabel.text = model.country

        windLabel.text = "Wind: \(model.wind)"
        humidityLabel.text = "Humidity: \(model.humidity)%"
        uvIndexLabel.text = "UV index: \(model.uvIndex)"
    }

}
