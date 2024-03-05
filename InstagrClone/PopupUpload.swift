//
//  PopupUpload.swift
//  InstagrClone
//
//  Created by Test on 1.03.24.
//

import UIKit
import SnapKit

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .gray
        self.frame = UIScreen.main.bounds
        
        self.addSubview(container)
        container.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(180)
            make.width.equalTo(250)
        }
        container.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(40)
            make.left.equalToSuperview().inset(20)
        }

        container.addSubview(stackButton)
        stackButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
            make.left.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
