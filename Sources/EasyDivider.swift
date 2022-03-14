// The MIT License (MIT)
//
// Copyright (c) 2022 Hossein Dehghan (github.com/hdehghan).
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, watchOS 7.0, macOS 10.15, *)
public struct EasyDivider: View {
    @Environment(\.colorScheme) var colorScheme

    var height: Double = 8
    var color: Color?

    public init(height: Double = 8, color: Color? = nil) {
        self.height = height
        if let color = color {
            self.color = color
        }
    }
    public var body: some View {
        Rectangle()
            .fill(colorScheme == .dark ? color ?? Color(white: 26.0 / 255.0) :
                    color ?? Color(white: 225.0 / 255.0))
            .frame(height: height)
    }
}
