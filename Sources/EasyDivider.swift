// The MIT License (MIT)
//
// Copyright (c) 2022 Hossein Dehghan (github.com/hdehghan).
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, watchOS 7.0, macOS 10.15, *)
public struct EasyDivider: View {
    @Environment(\.colorScheme) var colorScheme

    var height: Double = 8

    public init(height: Double = 8) {
        self.height = height
    }
    public var body: some View {
        Rectangle()
            .fill(colorScheme == .dark ?
                  Color(white: 26.0 / 255.0) :
                    Color(white: 225.0 / 255.0))
            .frame(height: height)
    }
}
