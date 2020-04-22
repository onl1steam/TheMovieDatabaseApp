//
//  PinView.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 07.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// View с точками индикации ввода пин-кода
final class PinView: UIView {
    
    // MARK: - Public Properties
    
    var circles = [CAShapeLayer]()
    
    var radius: CGFloat = 8 {
        didSet {
            removeCircles()
            appendCircles()
        }
    }
    
    enum State {
        case error
        case `default`
    }
    
    // MARK: - Private Properties
    
    private var activeCircleNumber: Int = 0 {
        didSet {
            if activeCircleNumber > 3 {
                activeCircleNumber = 3
            }
            if activeCircleNumber < 0 {
                activeCircleNumber = 0
            }
        }
    }
    
    // MARK: - UIView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        appendCircles()
    }
    
    // MARK: - Public Methods
    
    func changeCirclesColor(state: State) {
        var color = UIColor()
        switch state {
        case .default:
            color = UIColor.customPurpure
        case .error:
            color = UIColor.customRed
        }
        circles.forEach { circle in
            circle.fillColor = color.cgColor
        }
    }
    
    func removePinCode() {
        activeCircleNumber = 0
    }
    
    func fillCircle() {
        checkIsPinCodeStartedEnter()
        guard let circle = circles[safeIndex: activeCircleNumber] else { return }
        circle.fillColor = UIColor.customPurpure.cgColor
        activeCircleNumber += 1
    }
    
    func unfillCircle() {
        activeCircleNumber -= 1
        guard let circle = circles[safeIndex: activeCircleNumber] else { return }
        circle.fillColor = UIColor.darkBlue.cgColor
    }
    
    func removeCircles() {
        circles.forEach { circle in
            circle.removeFromSuperlayer()
        }
        circles.removeAll()
    }
    
    // MARK: - Private Methods
    
    private func checkIsPinCodeStartedEnter() {
        if activeCircleNumber == 0 {
            circles.forEach { circle in
                circle.fillColor = UIColor.darkBlue.cgColor
            }
        }
    }
    
    private func appendCircles() {
        var xCoord: CGFloat = frame.width / 2 - radius * 7 / 2
        let yCoord: CGFloat = 0
        
        for _ in 0...3 {
            let rect = CGRect(x: xCoord, y: yCoord, width: radius, height: radius)
            let dotPath = UIBezierPath(ovalIn: rect)

            let layer = CAShapeLayer()
            layer.path = dotPath.cgPath
            layer.fillColor = UIColor.darkBlue.cgColor
            
            xCoord += radius * 2
            circles.append(layer)
        }
        drawCircles()
    }
    
    private func drawCircles() {
        for circle in circles {
            layer.addSublayer(circle)
        }
    }
}
