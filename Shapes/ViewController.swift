//
//  ViewController.swift
//  Shapes
//
//  Created by Nicholas Alba on 8/30/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: UI Set-Up
    
    private func setUpUI() {
        view.backgroundColor = .white
        setUpTitleLabel()
        setUpTriangle()
        setUpButton()
    }
    
    private func setUpTitleLabel() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
    }
    
    private func setUpTriangle() {
        triangle = SierpinskiTriangle(frame: triangleFrame, length: sideLength, iterations: iterations)
        triangle.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        triangle.backgroundColor = .white
        view.addSubview(triangle)
    }
    
    private func setUpButton() {
        view.addSubview(evolutionButton)
        NSLayoutConstraint.activate([
            evolutionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            evolutionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        
        evolutionButton.addTarget(self, action: #selector(evolutionButtonPressed), for: .touchUpInside)
        evolutionButton.layer.borderWidth = 1.0
        evolutionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        if let buttonLabel = evolutionButton.titleLabel {
            evolutionButton.layer.cornerRadius = buttonLabel.frame.height / 2
        }
    }
    
    @objc private func evolutionButtonPressed() {
        iterations = iterations + 1
        triangle.removeFromSuperview()
        setUpTriangle()
    }
    
    // MARK: Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.text = "Sierpinski Triangle"
        return label
    }()
    
    private let evolutionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedTitle = NSAttributedString(string: "Evolve", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    private var triangle: SierpinskiTriangle!
    private let triangleFrame = CGRect(x: 0, y: 0, width: 800, height: 800)
    private let sideLength: CGFloat = 800
    private var iterations = 0
}

