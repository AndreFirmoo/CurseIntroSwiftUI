//
//  SceneDelegate.swift
//  Memorize
//
//  Created by Andre Jardim Firmo on 16/07/20.
//  Copyright © 2020 Andre Jardim Firmo. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

final public class SnackBar: UIView {
    
        /// Duration of message display
    public var duration: Float = 3
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(16)
        return label
    }()
    
    var bottomConstraints: NSLayoutConstraint?
    
    public init(message: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.backgroundColor = backgroundColor
        
        addShadow()
        layoutView()
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
    
        /// Explicit snack bar dismiss
    @objc func dismissSnackBar() {
        UIView.animate(
            withDuration: TimeInterval(0.2),
            delay: 0,
            options: .allowUserInteraction
        ) {
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            
        }
    }
}

    // MARK: - Animations
extension SnackBar {
        /// Sends snack bar down and starts progress animation
    public func showSnackBar() {
        self.transform = CGAffineTransform(translationX: 0, y: self.frame.height + 15)
        
        UIView.animate(
            withDuration: TimeInterval(0.2),
            delay: 0,
            options: .allowUserInteraction
        ) {
            self.transform = CGAffineTransform.identity
            UIAccessibility.post(notification: .screenChanged, argument: self)
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
                    guard let parentView = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
                    UIAccessibility.post(notification: .screenChanged, argument: parentView)
                    self.removeFromSuperview()
                }
            }
        )
    }
}

    // MARK: - View Cycle
extension SnackBar {
    private func layoutView() {
        guard let parentView = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        
            // MARK: - View hierarchy
        parentView.addSubview(self)
        self.addSubview(iconImageView)
        self.addSubview(messageLabel)
        
            // MARK: - component constraints
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 16),
            self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -16)
        ])
        
            // MARK: - iconImageView constraints
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
        
            // MARK: - messageLabel constraints
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 18),
            messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }
}

