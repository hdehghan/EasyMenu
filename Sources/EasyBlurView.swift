// The MIT License (MIT)
//
// Copyright (c) 2022 Hossein Dehghan (github.com/hdehghan).
//

import SwiftUI

#if os(macOS)
import AppKit
#else
import UIKit
#endif

#if os(iOS)
@available(iOS 13.0, *)
struct EasyBlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> some UIVisualEffectView {
        var view : UIVisualEffectView?
        defer {
            view = nil
        }
        autoreleasepool {
            view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        }
        return view!
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
#endif
