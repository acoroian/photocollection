//
//  ReditModel.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import Foundation

protocol Configurable {
    associatedtype T
    var model: T? { get set }
    func configureWithModel(_: T)
}
