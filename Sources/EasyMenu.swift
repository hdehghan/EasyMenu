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

@available(iOS 13.0, tvOS 13.0, watchOS 7.0, macOS 10.15, *)
public struct EasyMenu<Label, Content> : View where Label : View, Content : View {
    @Environment(\.colorScheme) var colorScheme

    let config = EasyMenuConfiguration.default
    // MARK: Properties
    @State private var height = 0.0
    @State private var showMenu: Bool = false
    @State private var screenWidth: Double = 0
    @State private var screenHeight: Double = 0
    
    var label: Label!
    var content: Content!
    
    // MARK: Transition
    /// A animated transition to be performed when displaying Menu
    /// By default, `.scale.combined(with: .opacity)`. with duration 0.25
    var transition: EasyTransition = .default

    // MARK: Init
    public init(@ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) {
        self.content = content()
        self.label = label()
    }

    /// Creates a menu that generates its label from a string.
    ///
    /// - Parameters:
    ///     - title: A string that describes the contents of the menu.
    ///     - content: A group of menu items.
    public init<S>(_ title: S, @ViewBuilder content: () -> Content) where Label == Text, S : StringProtocol {
        self.content = content()
        self.label = Text(title)
    }
    
    // MARK: Body
    public var body: some View {
        Button {
            withAnimation(.easeInOut(duration: config.animationDuration)) {
                showMenu.toggle()
            }
        } label: {
            label
        }
        .onAppear(perform: {
    #if os(macOS)
            if let screen = NSScreen.main {
                screenWidth = screen.frame.size.width
                screenHeight = screen.frame.size.height
            }
    #else
            screenWidth = UIScreen.main.bounds.size.width
            screenHeight = UIScreen.main.bounds.size.height * 2
    #endif
        })
        .overlay(backgroundOverlay())
        .overlay(menuOverlay())
//        .zIndex(Double.infinity)
    }
}

///
@available(iOS 13.0, tvOS 13.0, watchOS 7.0, macOS 10.15, *)
extension EasyMenu {
    func backgroundOverlay() -> some View {
        GeometryReader { geo in
            VStack {
                if showMenu {
                    Button {
                        withAnimation(.easeInOut(duration: config.animationDuration)) {
                            showMenu.toggle()
                        }
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .contentShape(Rectangle())
                    }
                    .offset(x: -geo.frame(in: .global).origin.x)
                }
            }
        }
        .frame(width: screenWidth, height: screenHeight)
    }
}

///
@available(iOS 13.0, tvOS 13.0, watchOS 7.0, macOS 10.15, *)
extension EasyMenu {
    @ViewBuilder
    func menuOverlay() -> some View {
        GeometryReader { geo in
            if showMenu {
                VStack(spacing: 0.0) {
                    content
                }
                .background(
                    GeometryReader { geo in
                        ZStack {
                            Color(white: colorScheme == .dark ? 75.0 / 255.0 : 225.0 / 255.0)
                                .padding()
                                .cornerRadius(config.cornerRadius)
                                .opacity(0.8)
                                .shadow(color: .black.opacity(0.5), radius: config.shadowRadius, x: 0, y: 10)
                            
                            #if os(macOS)
                            #else
                            EasyBlurView(style: colorScheme == .dark ? .systemUltraThinMaterialDark : .extraLight).cornerRadius(config.cornerRadius)
                            #endif
                        }
                        .onAppear {
                            self.height = geo.size.height
                        }
                    }
                )
                .offset(x: menuOffsetX(geo.frame(in: .global).origin.x), y: height / 2.0 + 16)
                .transition(transition.value)
            }
        }
        .frame(width: config.width, height: height)
    }
    func menuOffsetX(_ x: Double) -> Double {
        if x < 8 {
            return -x + 8
        } else if x + config.width > screenWidth - 8 {
            return screenWidth - x - config.width - 8
        }
        return 0
    }    
}
