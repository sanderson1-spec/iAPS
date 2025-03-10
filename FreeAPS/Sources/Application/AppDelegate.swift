import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

import Swinject

final class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        // Handle URL scheme
        let shortcutsManager = FreeAPSApp.resolver.resolve(ShortcutsManager.self)!
        return shortcutsManager.handleShortcut(url: url)
    }
}
