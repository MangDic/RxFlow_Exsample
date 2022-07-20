//
//  MainStaps.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import RxFlow

enum MainSteps: Step {
    case initialization
    case back
    
    case setting
    // Home
    case infoRequired
    // Message
    case receivedReuired
    case sentRequired
    // setting
    case firstRequired
    case secondRequired
    case thirdRequired
}
