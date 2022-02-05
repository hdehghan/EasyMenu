// The MIT License (MIT)
//
// Copyright (c) 2022 Hossein Dehghan (github.com/hdehghan).
//

import Foundation
import SwiftUI

@available(iOS 13.0, tvOS 13.0, watchOS 7.0, macOS 10.15, *)
public enum EasyTransition {
    case `default`
    case move
    
    var value: AnyTransition {
        switch self {
        case .default:
            return .scale.combined(with: .opacity)
        case .move:
            return .move(edge: .top).combined(with: .opacity)
        }
    }
}
