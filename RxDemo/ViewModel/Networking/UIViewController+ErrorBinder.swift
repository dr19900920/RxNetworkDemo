//
//  UIViewController+ErrorBinder.swift
//  RxDemo
//
//  Created by dr on 2019/7/8.
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
    var networkError: Binder<Error> {
        return Binder(base) {
            viewController, error in
            guard let e = error as? NetworkError else {
                return
            }
            
        }
    }
}

extension Reactive where Base: UIView {
    var networkError: Binder<Error> {
        return Binder(base) {
            view, error in
            guard let e = error as? NetworkError else {
                return
            }
            
        }
    }
}
