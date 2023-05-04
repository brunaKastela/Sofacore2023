import UIKit

class TeamView: BaseView {

    let teamIcon = UIImageView()
    let teamLabel = UILabel()
    let teamScoreLabel = UILabel()

    override func addViews() {
        addSubview(teamIcon)
        addSubview(teamLabel)
        addSubview(teamScoreLabel)
    }

    override func styleViews() {
        teamLabel.font(.bodyParagraph)
        teamScoreLabel.font(.bodyParagraph)

        teamScoreLabel.textAlignment(.right)
    }

    override func setupConstraints() {
        teamIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(0)
            make.size.equalTo(16)
        }

        teamLabel.snp.makeConstraints { make in
            make.leading.equalTo(teamIcon.snp.trailing).offset(8)
            make.verticalEdges.equalToSuperview()
        }

        teamScoreLabel.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(teamLabel.snp.trailing).offset(16)
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(32)
            make.trailing.equalToSuperview()
        }
    }

    override func setupGestureRecognizers() {
        // Default implementation is empty
    }

}
