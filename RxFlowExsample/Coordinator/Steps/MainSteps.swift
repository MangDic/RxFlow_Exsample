//
//  MainSteps.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/27.
//
import RxFlow

enum MainSteps: Step {
    case initialization
    case back
    
    case dismiss
    // Main
    case home
    case setting
    // Home
    case infoRequired
    // Setting
    case firstRequired
    case thirdRequired
    case modalRequired
    // News
    case newsRequired
}
