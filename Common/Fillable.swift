//
//  Fillable.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import Foundation

protocol Fillable {
    associatedtype T
    func fill(with model:T?) -> Void
}
