import UIKit
import SnapKit

final class HeaderView: BaseView {

    private let iconLabelImageView = UIImageView()

    private let leagueImageView = UIImageView()
    private let settingsImageView = UIImageView()

    override func addViews() {
        addSubview(iconLabelImageView)
        addSubview(leagueImageView)
        addSubview(settingsImageView)
    }

    override func styleViews() {
        backgroundColor = .colorPrimaryDefault

        iconLabelImageView.image = .iconLabel.withTintColor(.surfaceSurface1)
        leagueImageView.image = .trophyIcon.withTintColor(.surfaceSurface1)
        settingsImageView.image = .settingsIcon.withTintColor(.surfaceSurface1)
    }

    override func setupConstraints() {

        iconLabelImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(14)
            make.bottom.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(16)
        }

        leagueImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(12)
            make.bottom.equalToSuperview().inset(12)
            make.leading.greaterThanOrEqualTo(iconLabelImageView.snp.trailing).offset(24)
            make.size.equalTo(24)
        }

        settingsImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(12)
            make.bottom.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(leagueImageView.snp.trailing).offset(24)
            make.size.equalTo(24)
        }
    }

    override func setupGestureRecognizers() {
    }

}
