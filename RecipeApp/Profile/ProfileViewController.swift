// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для вью
protocol ProfileView: AnyObject {
    func updateView(model: ProfileModel)
}

/// Экран для профиля
final class ProfileViewController: UIViewController, ProfileView {
    // MARK: - Properties

    var presenter: ProfilePresenter?
    private var activities = ["bonuses", "terms & privacy policy", "log out"]

    // MARK: - Visual Components

    private lazy var tableHeaderView: HeaderView = {
        let view = HeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 240))
        view.delegate = self
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = tableHeaderView
        tableView.frame = view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        presenter?.viewDidLoad()
    }

    // MARK: - Private methods

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupConstraints() {}

    // MARK: - Public methods

    func updateView(model: ProfileModel) {
        activities = model.categories
        tableHeaderView.avatarImageView.image = UIImage(named: "\(model.profileImageView)")
        tableHeaderView.nameLabel.text = "\(model.name) \(model.surname)"
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        activities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableViewCell.identifier,
            for: indexPath
        ) as? ProfileTableViewCell else { return UITableViewCell() }
        cell.configure(activities[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let detentsVC = DetentsViewController()
            if let sheet = detentsVC.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            present(detentsVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 1 { 
            presenter?.showTermsPrivacyPolicy()
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - HeaderViewDelegate

extension ProfileViewController: HeaderViewDelegate {
    func editButtonDidPress() {
        let alert = UIAlertController(title: "Change your name and surname", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let submitAction = UIAlertAction(title: "OK", style: .default) { [unowned alert] _ in
            let answer = alert.textFields?[0]
            self.tableHeaderView.nameLabel.text = answer?.text
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
