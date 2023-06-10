import UIKit

protocol NavigationHeaderDelegate: AnyObject {

    func backButtonTapped()

}

class NavigationHeaderView: BaseView {

    private var tournamentModel: Tournament?

    weak var delegate: NavigationHeaderDelegate?

    private let leagueDetailsView = UIView()

    private let backButtonImage = UIImageView()
    private let leagueIcon = UIImageView()
    private var leagueDescription = UILabel()

    func configure(for tournament: Tournament) {
        self.tournamentModel = tournament

        if let tournamentModel = tournamentModel as? Tournament {
            leagueIcon.sd_setImage(
                with: URL(string: "https://academy.dev.sofascore.com/tournament/\(tournamentModel.id)/image"))

            leagueDescription.text = "\(tournamentModel.sport.name), \(tournamentModel.country.name), \(tournamentModel.name)"
        }
    }

    override func addViews() {
        addSubview(leagueDetailsView)

        leagueDetailsView.addSubview(backButtonImage)
        leagueDetailsView.addSubview(leagueIcon)
        leagueDetailsView.addSubview(leagueDescription)
    }

    override func styleViews() {
        backgroundColor = .surfaceSurface1

        backButtonImage.image(.pointerBack)

        leagueDescription.font(.micro)
        leagueDescription.textColor(.onSurfaceOnSurfaceLv2)
        leagueDescription.lineBreakMode = .byTruncatingTail
        leagueDescription.numberOfLines = 1

    }

    override func setupConstraints() {
        leagueDetailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backButtonImage.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalToSuperview()
        }

        leagueIcon.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.leading.equalTo(backButtonImage.snp.trailing).offset(28)
            make.verticalEdges.equalToSuperview().inset(4)
        }

        leagueDescription.snp.makeConstraints { make in
            make.leading.equalTo(leagueIcon.snp.trailing).offset(8)
            make.verticalEdges.equalToSuperview().inset(4)
            make.trailing.lessThanOrEqualToSuperview()
        }

    }

    override func setupGestureRecognizers() {
        backButtonImage.isUserInteractionEnabled = true
        backButtonImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonTapped)))
    }

    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }

}
