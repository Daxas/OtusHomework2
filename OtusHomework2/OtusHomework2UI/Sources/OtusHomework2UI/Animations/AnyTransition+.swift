//
//  AnyTransition+.swift
//  OtusHomework2
//
//  Created by Daria.S on 25.10.2021.
//

import Foundation
import SwiftUI

extension AnyTransition {
    public static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading).combined(with: .opacity)
        let removal = AnyTransition.scale.combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
