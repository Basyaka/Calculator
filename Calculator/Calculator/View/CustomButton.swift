//
//  CustomButton.swift
//  Calculator
//
//  Created by Vlad Novik on 8.02.21.
//

import UIKit

protocol CustomButtonDelegate: NSObjectProtocol {
    func buttonTapped(sender: UIButton)
}

class CustomButton: UIButton {

    weak var delegate: CustomButtonDelegate?
    
    init(title: String, backgroundColor: UIColor, tag: Int) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.tag = tag
        setColorForTitle(backgroundColor: backgroundColor)
        self.backgroundColor = backgroundColor
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setColorForTitle(backgroundColor: UIColor) {
        let titleColor: UIColor = backgroundColor.isDarkColor ? .white : .black
        self.setTitleColor(titleColor, for: .normal)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        delegate?.buttonTapped(sender: sender)
    }

}
