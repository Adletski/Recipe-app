// CustomControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Public Properties

/// кастомные стейты
enum ButtonState {
    case normal
    case highToLow
    case lowToHigh
}

/// Протокол источника данных для выбора сортировки
protocol SortingPickerDataSource {
    /// Возвращает количество элементов в контроле выбора сортировки
    func sortPickerCount(_ dayPicker: SortingViewControl) -> Int
    /// Возвращает заголовок элемента сортировки для указанного индекса
    func sortPickerTitle(_ dayPicker: SortingViewControl, indexPath: IndexPath) -> String
}

/// Протокол делегата управления сортировкой
protocol SortingViewControlDelegate {
    /// Вызывается при нажатии на кнопку сортировки
    func onButtonPressed(state: ButtonState)
}

// MARK: - Visual Components

/// Класс кастомного контрола для выбора сортировки
final class SortingViewControl: UIControl {
    /// Источник данных для контрола
    public var dataSource: SortingPickerDataSource? {
        didSet {
            setupView()
        }
    }

    /// Делегат управления контролом
    var delegate: SortingViewControlDelegate?
    private var buttons: [RecipeButton] = []
    private var stackView: UIStackView?

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView?.frame = bounds
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    /// Настройка внешнего вида контрола
    func setupView() {
        let count = dataSource?.sortPickerCount(self)

        for item in 0 ..< (count ?? 0) {
            let indexPath = IndexPath(row: item, section: 0)
            let title = dataSource?.sortPickerTitle(self, indexPath: indexPath)
            let button = RecipeButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tag = item
            button.backgroundColor = #colorLiteral(red: 0.9535714984, green: 0.9660330415, blue: 0.9660820365, alpha: 1)
            button.layer.cornerRadius = 20
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.addTarget(self, action: #selector(selectedButton), for: .touchUpInside)
            button.setImage(UIImage(named: "up"), for: .normal)
            button.tintColor = .black
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            button.semanticContentAttribute = .forceRightToLeft
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 112).isActive = true
            button.heightAnchor.constraint(equalToConstant: 36).isActive = true
            button.customState = .normal
            buttons.append(button)
            addSubview(button)
        }

        stackView = UIStackView(arrangedSubviews: buttons)
        if let stackView {
            addSubview(stackView)
        }

        stackView?.spacing = 8
        stackView?.axis = .horizontal
        stackView?.alignment = .center
        stackView?.distribution = .fillEqually
    }

    /// Изменить состояние кнопки
    func changeState(button: RecipeButton) {
        switch button.customState {
        case .normal:
            button.setTitleColor(.white, for: .normal)
            button.tintColor = .white
            button.backgroundColor = #colorLiteral(red: 0.5132525563, green: 0.7558944225, blue: 0.7756446004, alpha: 1)
            button.customState = .highToLow
        case .highToLow:
            button.setTitleColor(.white, for: .normal)
            button.tintColor = .white
            button.backgroundColor = #colorLiteral(red: 0.5132525563, green: 0.7558944225, blue: 0.7756446004, alpha: 1)
            button.setImage(UIImage(named: "down"), for: .normal)
            button.customState = .lowToHigh
        case .lowToHigh:
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9535714984, green: 0.9660330415, blue: 0.9660820365, alpha: 1)
            button.tintColor = .black
            button.setImage(UIImage(named: "up"), for: .normal)
            button.customState = .normal
        case .none:
            break
        }
    }

    /// Создание изображения стрелки вверх
    private func makeUpImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "up")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    // MARK: - IBAction

    /// Обработка нажатия на кнопку
    @objc func selectedButton(sender: RecipeButton) {
        changeState(button: sender)
        print(sender.customState)
        if let state = sender.customState {
            delegate?.onButtonPressed(state: state)
        }
    }
}

// MARK: - Visual Components

/// Класс кастомной кнопки
final class RecipeButton: UIButton {
    var customState: ButtonState?
}
