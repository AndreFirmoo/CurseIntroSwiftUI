# Stanford University's course CS193p (Developing Applications for iOS using SwiftUI) 1 of 12

## Intro SwiftUI

final public class SnackBar: UIView {
    /// Duration of message display
    public var duration: Float = 3

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(16)
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ok", for: .normal)
        return button
    }()

    public init(message: String, backgroundColor: UIColor, aboveView: UIView? = nil) {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.backgroundColor = backgroundColor

        addShadow()
        layoutView(aboveView: aboveView)
        messageLabel.text = message
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 6
    }

    @objc func dismissSnackBar() {
        UIView.animate(
            withDuration: TimeInterval(0.2),
            delay: 0,
            options: .allowUserInteraction
        ) {
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        }
    }

    func showSnackBar() {
        self.transform = CGAffineTransform(translationX: 0, y: self.frame.height + 15)

        UIView.animate(
            withDuration: TimeInterval(0.2),
            delay: 0,
            options: .allowUserInteraction
        ) {
            self.transform = CGAffineTransform.identity
        } completion: { _ in
            self.hideSnackBar()
        }
    }

    private func hideSnackBar() {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(duration),
            execute: {
                UIView.animate(
                    withDuration: TimeInterval(0.2),
                    delay: 0,
                    options: .allowUserInteraction
                ) {
                    self.transform = CGAffineTransform(translationX: 0, y: self.frame.height + 15)
                } completion: { _ in
                    self.removeFromSuperview()
                }
            }
        )
    }

    private func layoutView(aboveView: UIView?) {
        guard let parentView = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }

        parentView.addSubview(self)
        self.addSubview(messageLabel)

        if let aboveView = aboveView {
            NSLayoutConstraint.activate([
                self.bottomAnchor.constraint(equalTo: aboveView.topAnchor, constant: -8),
                self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 16),
                self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -16)
            ])
        } else {
            NSLayoutConstraint.activate([
                self.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
                self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 16),
                self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -16)
            ])
        }

        // Default messageLabel constraints
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 60),
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }

    func applyVariant(variant: SnackBarContentType) {
        switch variant {
        case .singleLine:
            // Logic for single line snackbar
            // For example, adjust message label constraints for a single line.
            messageLabel.font = UIFont.systemFont(ofSize: 16)
        case .singleLineAndAction:
            // Logic for single line snackbar with an action
            // Add a button and adjust constraints.
            self.addSubview(actionButton)
            setupConstraintsActionButton()
            // Add constraints for the button here.
        case .doubleLineAndAction:
            // Logic for double line snackbar with an action
            messageLabel.numberOfLines = 2
            // Add a button and adjust constraints.
        case .largeDoubleLineAndAction:
            // Logic for large double line snackbar with an action
            messageLabel.numberOfLines = 2
            messageLabel.font = UIFont.systemFont(ofSize: 18)
            // Add a button and adjust constraints.
        }
    }
    
    private func setupConstraintsActionButton() {
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            actionButton.leadingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 11),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            actionButton.widthAnchor.constraint(equalToConstant: 24),
            actionButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

enum SnackBarContentType {
    case singleLine
    case singleLineAndAction
    case doubleLineAndAction
    case largeDoubleLineAndAction
}
