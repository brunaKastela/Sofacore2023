import UIKit
import SnapKit

class DividerView: UITableViewHeaderFooterView, Reusable {

    private let dividerView = UIView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}

extension DividerView: BaseViewProtocol {

    func addViews() {
        addSubview(dividerView)
    }

    func styleViews() {
        dividerView.backgroundColor(.onSurfaceOnSurfaceLv4)
    }

    func setupConstraints() {
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
        }
    }

}
