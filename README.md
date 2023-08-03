# Stanford University's course CS193p (Developing Applications for iOS using SwiftUI) 1 of 12

## Intro SwiftUI

class DraggableTopView: UIView {

    private var topLimit: CGFloat = 100
    private var originalPosition: CGPoint = .zero
    private var isExpanded = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupPanGesture()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupPanGesture()
    }

    convenience init(topLimit: CGFloat) {
        self.init(frame: .zero)
        self.topLimit = topLimit
    }

    private func setupView() {
        backgroundColor = .white
        clipsToBounds = true
    }

    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGesture)
    }

    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self)

        switch gestureRecognizer.state {
        case .began:
            originalPosition = center
        case .changed:
            if isExpanded {
                let newYPosition = max(originalPosition.y + translation.y, originalPosition.y - topLimit)
                center = CGPoint(x: center.x, y: newYPosition)
            } else {
                let newYPosition = min(originalPosition.y + translation.y, originalPosition.y)
                center = CGPoint(x: center.x, y: newYPosition)
            }
        case .ended, .cancelled:
            if isExpanded {
                if center.y <= originalPosition.y - topLimit / 2 {
                    animateToTopLimit()
                } else {
                    animateToOriginalPosition()
                }
            } else {
                if center.y >= originalPosition.y - topLimit / 2 {
                    animateToExpandedPosition()
                } else {
                    animateToOriginalPosition()
                }
            }
        default:
            break
        }
    }

    private func animateToTopLimit() {
        isExpanded = false
        UIView.animate(withDuration: 0.3) {
            self.center = CGPoint(x: self.center.x, y: self.originalPosition.y - self.topLimit)
        }
    }

    private func animateToExpandedPosition() {
        isExpanded = true
        UIView.animate(withDuration: 0.3) {
            self.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.topLimit * 2)
            self.center = CGPoint(x: self.center.x, y: self.originalPosition.y - self.topLimit / 2)
        }
    }

    private func animateToOriginalPosition() {
        isExpanded = false
        UIView.animate(withDuration: 0.3) {
            self.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.topLimit)
            self.center = self.originalPosition
        }
    }
}
