//
//  PopupUpload.swift
//  InstagrClone
//
//  Created by Test on 1.03.24.
//

import UIKit

class Popup: UIView {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.text = "Your image was successfully uploaded"
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let buttonOK: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("OK", for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(nil, action: #selector(UploadViewController.popupClose), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonCancel: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Cancel", for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(nil, action: #selector(UploadViewController.popupClose), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let container: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var stackButton: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [buttonOK, buttonCancel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textLabel, stackButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .gray
        self.frame = UIScreen.main.bounds
        
        self.addSubview(container)
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        
        container.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: stack.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: stack.trailingAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5).isActive = true
        stack.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        stackButton.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 10).isActive = true
        stackButton.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
