//
//  ViewModelType.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/20.
//

import Foundation

protocol ViewModelType: ViewModel {
    // ViewModel
    associatedtype ViewModel: ViewModelType

    // Input
    associatedtype Input

    // Output
    associatedtype Output

    func transform(req: ViewModel.Input) -> ViewModel.Output
}
