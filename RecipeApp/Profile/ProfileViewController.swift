// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для вью
protocol ProfileView: AnyObject {
    /// Обновляет вид профиля с данными модели
    func updateView(model: ProfileModel)
    func showTermsPrivacyPolicy()
}

/// Экран для профиля
final class ProfileViewController: UIViewController, ProfileView {
    // MARK: - Constants

    enum Constants {
        static let timer: CGFloat = 2
        static let change = "Change your name and surname"
        static let ok = "OK"
        static let cancel = "Cancel"
        static let profile = "Profile"
    }

    // MARK: - Properties

    var presenter: ProfilePresenter?
    private var activities = ["bonuses", "terms & privacy policy", "log out"]
    private var termsPrivacyPolicyView: TermsPrivacyPolicyView?
    private var visualEffect: UIVisualEffectView?

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

    /// Настройка пользовательского интерфейса
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        title = Constants.profile
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupConstraints() {}

    // MARK: - Public methods

    /// Обновляет вид профиля с данными модели
    func updateView(model: ProfileModel) {
        activities = model.categories
        tableHeaderView.avatarImageView.image = UIImage(named: "\(model.profileImageView)")
        tableHeaderView.nameLabel.text = "\(model.name) \(model.surname)"
    }

    /// Отображение  условий и политики конфиденциальности
    func showTermsPrivacyPolicy() {
        termsPrivacyPolicyView = TermsPrivacyPolicyView(frame: CGRect(
            x: 0,
            y: view.frame.height - 500,
            width: view.bounds.width,
            height: view.bounds.height
        ))
        visualEffect = UIVisualEffectView(frame: view.frame)
        guard let visualEffect = visualEffect else { return }
        view.addSubview(visualEffect)
        let blurAnimation = UIViewPropertyAnimator(duration: 1, dampingRatio: 1) {
            self.visualEffect?.effect = UIBlurEffect(style: .light)
        }
        blurAnimation.startAnimation()
        let scene = UIApplication.shared.connectedScenes
        let windowsScene = scene.first as? UIWindowScene
        UIView.animate(withDuration: 2) {
            windowsScene?.windows.last?.addSubview(self.termsPrivacyPolicyView ?? TermsPrivacyPolicyView())
        }

        termsPrivacyPolicyView?.handler = { [weak self] in
            self?.visualEffect?.isUserInteractionEnabled = false
            let blurAnimation = UIViewPropertyAnimator(duration: 1, dampingRatio: 1) {
                self?.visualEffect?.effect = nil
            }
            blurAnimation.startAnimation()
            self?.visualEffect?.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.timer) {
                self?.termsPrivacyPolicyView?.removeFromSuperview()
                blurAnimation.stopAnimation(true)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    /// Возвращает количество строк в указанной секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        activities.count
    }

    /// Возвращает ячейку для указанного индекса
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
    /// Вызывается при выборе ячейки таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let detentsVC = DetentsViewController()
            if let sheet = detentsVC.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            present(detentsVC, animated: true)
        } else if indexPath.row == 1 {
            presenter?.showTermsPrivacyPolicy()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - HeaderViewDelegate

extension ProfileViewController: HeaderViewDelegate {
    /// Обрабатывает нажатие кнопки редактирования
    func editButtonDidPress() {
        let alert = UIAlertController(title: Constants.change, message: nil, preferredStyle: .alert)
        alert.addTextField()
        let submitAction = UIAlertAction(title: Constants.ok, style: .default) { [unowned alert] _ in
            let answer = alert.textFields?[0]
            self.tableHeaderView.nameLabel.text = answer?.text
        }
        let cancelAction = UIAlertAction(title: Constants.cancel, style: .cancel)
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
