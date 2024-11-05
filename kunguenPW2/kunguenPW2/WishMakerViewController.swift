//
//  WishMakerViewController.swift
//  kunguenPW2
//
//  Created by Нгуен Куиет Чыонг on 04.11.2024.
//

import UIKit

final class WishMakerViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 255
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let title: String = "WishMaker"
        static let description: String = "This app will bring joy and will fulfill three of your wishes!" + "\n\t - The first wish is to change the background color."
        static let titleFontSize: CGFloat = 32
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = -20
        static let stackLeading: CGFloat = 20
        static let titleLeading: CGFloat = 20
        static let titleTop: CGFloat = 50
        static let descriptionFontSize: CGFloat = 20
        static let descriptionLeading: CGFloat = 20
        static let descriptionTrailing: CGFloat = 20
        static let descriptionTop: CGFloat = 50
        static let stackCornerRadius: CGFloat = 20
        static let buttonHeight: CGFloat = 50
        static let buttonBottom: CGFloat = 40
        static let buttonSide: CGFloat = 20
        static let buttonText = "My Wishes"
        static let buttonRadius: CGFloat = 20
    }
    
    // MARK: - Properties
    private let addWishButton: UIButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private var redNumber: Double = 0
    private var greenNumber: Double = 0
    private var blueNumber: Double = 0
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - UI Configuration
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        configureTitle()
        configureDescription()
        configureAddWishButton()
        configureSliders()
    }
    
    // MARK: - Title Configuration
    
    private func configureTitle() {
        titleLabel.textColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Constants.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        
        view.addSubview(titleLabel)
        titleLabel.pinCenterX(to: view.centerXAnchor)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
    }
    
    // MARK: - Description Configuration

    private func configureDescription() {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = Constants.description
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.5

        view.addSubview(descriptionLabel)
        descriptionLabel.pinCenterX(to: view.centerXAnchor)
        descriptionLabel.pinLeft(to: view.leadingAnchor, Constants.descriptionLeading)
        descriptionLabel.pinRight(to: view.trailingAnchor, Constants.descriptionTrailing)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionTop)
    }
    
    // MARK: - Sliders Configuration
    
    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackCornerRadius
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            stack.addArrangedSubview(slider)
        }
        
        stack.pinCenterX(to: view.centerXAnchor)
        stack.pinLeft(to: view.leadingAnchor, Constants.stackLeading)
        stack.pinBottom(to: addWishButton.topAnchor, -1 * Constants.stackBottom)
        
        sliderRed.valueChanged = { [weak self] value in
            guard let self = self else { return }
            self.redNumber = value / 255
            self.updateBackgroundColor()
        }

        sliderGreen.valueChanged = { [weak self] value in
            guard let self = self else { return }
            self.greenNumber = value / 255
            self.updateBackgroundColor()
        }

        sliderBlue.valueChanged = { [weak self] value in
            guard let self = self else { return }
            self.blueNumber = value / 255
            self.updateBackgroundColor()
        }
    }
    
    // MARK: - Button Configuration

    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.pinBottom(to: view, Constants.buttonBottom)
        addWishButton.pinHorizontal(to: view, Constants.buttonSide)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)
        
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    @objc private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    // MARK: - Helper Methods
    
    private func updateBackgroundColor() {
        view.backgroundColor = UIColor(
            red: CGFloat(redNumber),
            green: CGFloat(greenNumber),
            blue: CGFloat(blueNumber),
            alpha: 1
        )
    }
}
