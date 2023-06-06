import UIKit
import SnapKit

protocol DatePickerDelegate: AnyObject {

    func onDateSelected(_ date: Date)

}

class DatePickerViewController: UIViewController, BaseViewProtocol {

    let viewModel: DatePickerViewModel
    var collectionView: UICollectionView!

    weak var delegate: DatePickerDelegate?

    init(viewModel: DatePickerViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let date = UserPreferences.selectedDateIndex as? Date {
            selectItem(withDate: date)
        } else {
            selectItem(withDate: Date())
        }
    }

    func addViews() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 7, height: 48)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
    }

    func styleViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DatePickerViewCell.self, forCellWithReuseIdentifier: "test")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .colorPrimaryVariant
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension DatePickerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dates.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as? DatePickerViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: viewModel.dates[indexPath.row])

        return cell
    }

}

extension DatePickerViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDate = viewModel.dates[indexPath.row].date
        delegate?.onDateSelected(selectedDate)

        guard let cell = collectionView.cellForItem(at: indexPath) as? DatePickerViewCell else { return }
        cell.showBar()

        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    func selectItem(withDate date: Date) {
        if let index = viewModel.dates.firstIndex(where: { Calendar.current.isDate(date, inSameDayAs: $0.date) }) {
            let indexPath = IndexPath(row: index, section: 0)

            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DatePickerViewCell else { return }
        cell.hideBar()
    }

}
