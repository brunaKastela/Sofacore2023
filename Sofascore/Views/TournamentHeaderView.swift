import UIKit
import SnapKit
import SDWebImage

class TournamentHeaderView: UITableViewCell, Reusable {

    private let backView = UIView()

    private let iconImageView = UIImageView()

    private let leagueStackView = UIStackView()
    private let countryLabel = UILabel()
    private let pointerImageView = UIImageView()
    private let leagueLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        countryLabel.text("")
        leagueLabel.text("")

        iconImageView.image = nil
    }

}

extension TournamentHeaderView: BaseViewProtocol {

    func addViews() {
        addSubview(backView)
        addSubview(iconImageView)
        addSubview(leagueStackView)

        leagueStackView.addArrangedSubviews([countryLabel, pointerImageView, leagueLabel])
    }

    func styleViews() {
        backView.backgroundColor = .surfaceSurface1

        countryLabel.font = .systemFont(ofSize: 14, weight: .bold)
        countryLabel.textColor = .black
        countryLabel.lineBreakMode = .byTruncatingTail
        countryLabel.numberOfLines = 1

        leagueLabel.font = .systemFont(ofSize: 14, weight: .bold)
        leagueLabel.textColor = .onSurfaceOnSurfaceLv2
        leagueLabel.lineBreakMode = .byTruncatingTail
        leagueLabel.numberOfLines = 1

        leagueStackView.axis = .horizontal
        leagueStackView.alignment = .center
        leagueStackView.distribution = .fill

        pointerImageView.image = .pointerRight.withRenderingMode(.alwaysTemplate)
        pointerImageView.tintColor(.onSurfaceOnSurfaceLv2)
    }

    func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.leading.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(12)
        }

        leagueStackView.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(32)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }

}

extension TournamentHeaderView {

    func configureTournamentCell(with model: Tournament) {
        countryLabel.text = model.country.name
        leagueLabel.text = model.name

        iconImageView.sd_setImage(
            with: URL(string: "https://academy.dev.sofascore.com/tournament/\(model.id)/image"))
    }

}
