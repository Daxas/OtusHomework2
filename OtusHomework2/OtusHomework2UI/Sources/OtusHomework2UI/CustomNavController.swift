//
//  CustomNavController.swift
//  
//
//  Created by Daria.S on 06.11.2021.
//

import Foundation
import SwiftUI

public struct NavControllerView<Content>: View where Content: View {
    
    @ObservedObject private var viewModel: NavControllerViewModel
    
    private let content: Content
    private let transition: (push: AnyTransition, pop: AnyTransition)
    
    public init(transition: NavTrasition, easing: Animation = .easeOut(duration: 0.33), @ViewBuilder content: @escaping ()-> Content) {
        viewModel = NavControllerViewModel(easing: easing)
        self.content = content()
        
        switch transition {
        case .custom(let trans):
            self.transition = (trans, trans)
        case .none:
            self.transition = (.identity, .identity)
        }
    }
    
    public var body: some View {
        let isRoot = viewModel.currentScreen == nil
        return ZStack {
            if isRoot {
                content
                    .transition(viewModel.navigatuonType == .push ? transition.push : transition.pop)
                    .environmentObject(viewModel)
            } else {
                viewModel.currentScreen?.nextScreen
                    .transition(viewModel.navigatuonType == .push ? transition.push : transition.pop)
                    .environmentObject(viewModel)
            }
        }
    }
}

public struct NavPushButton<Label, Destination>: View where Label: View, Destination: View {
    
    @EnvironmentObject private var viewModel: NavControllerViewModel
    
    private let destination: Destination
    private let label: Label
    
    public init(destination: Destination, @ViewBuilder label: @escaping ()->Label) {
        self.destination = destination
        self.label = label()
    }
    
    public var body: some View {
        label.onTapGesture {
            viewModel.push(destination)
        }
    }
}

public struct NavPopButton<Label>: View where Label: View {
    
    @EnvironmentObject private var viewModel: NavControllerViewModel
    
    private let destination: PopDestination
    private let label: Label
    
    public init(destination: PopDestination, @ViewBuilder label: @escaping ()->Label) {
        self.destination = destination
        self.label = label()
    }
    
    public var body: some View {
        label.onTapGesture {
            viewModel.pop(to: destination)
        }
    }
}

final class NavControllerViewModel: ObservableObject {
    
    private let easing: Animation
    var navigatuonType = NavType.push
    
    @Published fileprivate var currentScreen: Screen?
    
    private var screenStack = ScreenStack() {
        didSet {
            currentScreen = screenStack.top()
        }
    }
    
    init(easing: Animation) {
        self.easing = easing
    }
    
    func push<S: View>(_ screenView: S) {
        withAnimation(easing) {
            navigatuonType = .push
            let screen = Screen(id: UUID().uuidString, nextScreen: AnyView(screenView))
            screenStack.push(screen)
        }
    }
    
    func pop(to destination: PopDestination) {
        withAnimation(easing) {
            navigatuonType = .pop
            switch destination {
            case .previous:
                screenStack.popToPrevious()
            case .root:
                screenStack.popToRoot()
            }
        }
    }
}


public enum PopDestination {
    case previous
    case root
}

public enum NavType {
    case push
    case pop
}

public enum NavTrasition {
    case none
    case custom(AnyTransition)
}

private struct ScreenStack {
    
    private var screens: [Screen] = .init()
    
    func top() -> Screen? {
        screens.last
    }
    
    mutating func push(_ screen: Screen) {
        screens.append(screen)
    }
    
    mutating func popToPrevious() {
        _ = screens.popLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
}


struct Screen: Identifiable, Equatable {
    
    let id: String
    let nextScreen: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
    
}
