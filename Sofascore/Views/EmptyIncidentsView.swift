import UIKit

class EmptyIncidentsView: BaseView {

    let containerStack = UIStackView()

    let statusView = UIView()
    let statusLabel = UILabel()

    let detailsLinkView = UIView()
    let detailsLinkLabel = UILabel()

    private enum Constants {

        static let statausLabelText = "No results yet."
        static let detailsLinkText = "View Tournament Details"

    }

    override func addViews() {
        addSubview(containerStack)

        containerStack.addArrangedSubviews([statusView, detailsLinkView])

        statusView.addSubview(statusLabel)
        detailsLinkView.addSubview(detailsLinkLabel)
    }

    override func styleViews() {
        backgroundColor = .surfaceSurface1

        containerStack.axis = .vertical
        containerStack.alignment = .center
        containerStack.distribution = .fill
        containerStack.spacing = 16

        statusView.backgroundColor = .surfaceSurface2
        statusView.layer.cornerRadius = 8
        statusView.clipsToBounds = true

        statusLabel.textAlignment = .center
        statusLabel.textColor = .onSurfaceOnSurfaceLv2
        statusLabel.font = .bodyParagraph
        statusLabel.text = Constants.statausLabelText

        detailsLinkView.borderColor(.colorPrimaryDefault)
        detailsLinkView.borderWidth(2)
        detailsLinkView.layer.cornerRadius = 2
        detailsLinkView.clipsToBounds = true

        detailsLinkLabel.textAlignment = .center
        detailsLinkLabel.textColor = .colorPrimaryDefault
        detailsLinkLabel.font = .action
        detailsLinkLabel.text = Constants.detailsLinkText
    }

    override func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(36)
        }

        statusView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(8)
            make.height.equalTo(52)
        }

        statusLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        detailsLinkView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }

        detailsLinkLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }

}
