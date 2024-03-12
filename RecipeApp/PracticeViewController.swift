// PracticeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class PracticeViewController: UIViewController {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(section: createLayout())
        layout.register(RoundedBackgroundView.self, forDecorationViewOfKind: RoundedBackgroundView.reuseIdentifier)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .cyan
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        cv.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell2")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }

    func createLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])

        let containerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .estimated(1)
            ),
            subitems: Array(repeating: group, count: 2)
        )

        let section = NSCollectionLayoutSection(group: containerGroup)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
        section
            .decorationItems =
            [NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.reuseIdentifier)]
        return section
    }
}

extension PracticeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? CustomCollectionViewCell
        else { return UICollectionViewCell() }

        return cell
    }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

final class RoundedBackgroundView: UICollectionReusableView {
    private var insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(insetView)

        NSLayoutConstraint.activate([
            insetView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            trailingAnchor.constraint(equalTo: insetView.trailingAnchor, constant: 15),
            insetView.topAnchor.constraint(equalTo: topAnchor),
            insetView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
