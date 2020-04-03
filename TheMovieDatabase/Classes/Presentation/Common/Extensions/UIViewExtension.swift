//
//  UIViewExtension.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 03.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Устанавливает констрейнты на прямоугольник.
    ///
    /// - Parameters:
    ///     - width: Ширина прямоугольника.
    ///     - height: Высота прямоугольника.
    func constraintRectangle(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = heightAnchor.constraint(equalToConstant: height)
        let widthConstraint = widthAnchor.constraint(equalToConstant: width)
        NSLayoutConstraint.activate([heightConstraint, widthConstraint])
    }
    
    /// Устанавливает констрейнты контейнера, прибитого к View по бокам с отступом и снизу.
    ///
    /// - Parameters:
    ///     - sideMargin: Отступы по бокам.
    ///     - topMargin: Отступ сверху.
    ///     - bottomMargin: Отступ снизу.
    ///     - parentView: View, на котором располагается объект.
    ///     - topView: View, от которого нужен отступ сверху.
    func constraintContainer(
        sideMargin: CGFloat,
        topMargin: CGFloat,
        bottomMargin: CGFloat,
        parentView: UIView,
        topView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: sideMargin)
        let trailingConstraint = trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -sideMargin)
        let bottomConstraint = bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: bottomMargin)
        let topConstraint = topAnchor.constraint(equalTo: topView.bottomAnchor, constant: topMargin)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, bottomConstraint, topConstraint])
    }
    
    /// Устанавливает объект по середине
    ///
    /// - Parameters:
    ///     - parentView: Ширина прямоугольника.
    func constraintMiddle(parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = centerXAnchor.constraint(equalTo: parentView.centerXAnchor)
        let centerYConstraint = centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
    }
    
    /// Устанавливает объект в виде строки/кнопки-строки
    ///
    /// - Parameters:
    ///     - sideMargin: Отступы по бокам.
    ///     - topMargin: Отступ сверху.
    ///     - parentView: View, на котором располагается объект.
    ///     - topView: View, от которого нужен отступ сверху.
    func constraintStringView(sideMargin: CGFloat, topMargin: CGFloat, parentView: UIView, topView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: sideMargin)
        let trailingConstraint = trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -sideMargin)
        let topConstraint = topAnchor.constraint(equalTo: topView.bottomAnchor, constant: topMargin)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint])
    }
    
    /// Устанавливает объект в виде строки/кнопки-строки к родительской view
    ///
    /// - Parameters:
    ///     - sideMargin: Отступы по бокам.
    ///     - topMargin: Отступ сверху.
    ///     - parentView: View, на котором располагается объект.
    func constraintStringMainView(sideMargin: CGFloat, topMargin: CGFloat, parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: sideMargin)
        let trailingConstraint = trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -sideMargin)
        let topConstraint = topAnchor.constraint(equalTo: parentView.topAnchor, constant: topMargin)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint])
    }
}
