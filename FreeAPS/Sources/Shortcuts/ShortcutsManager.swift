import Foundation
import Swinject

protocol ShortcutsManager {
    func handleShortcut(url: URL) -> Bool
}

final class BaseShortcutsManager: ShortcutsManager, Injectable {
    @Injected() private var settingsManager: SettingsManager!
    @Injected() private var apsManager: APSManager!
    
    init(resolver: Resolver) {
        injectServices(resolver)
    }
    
    func handleShortcut(url: URL) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return false
        }
        
        // Handle SMS remote bolus
        if components.scheme == "iaps" && components.host == "smsremotebolus" {
            return handleSMSRemoteBolus(components: components)
        }
        
        return false
    }
    
    private func handleSMSRemoteBolus(components: URLComponents) -> Bool {
        // Check if SMS remote bolus is enabled
        guard settingsManager.settings.smsRemoteEnabled else {
            return false
        }
        
        // Parse query parameters
        guard let queryItems = components.queryItems else {
            return false
        }
        
        // Extract parameters
        guard let amountString = queryItems.first(where: { $0.name == "amount" })?.value,
              let pinString = queryItems.first(where: { $0.name == "pin" })?.value,
              let phoneNumber = queryItems.first(where: { $0.name == "phone" })?.value else {
            return false
        }
        
        // Validate phone number
        let allowedNumbers = settingsManager.settings.smsRemoteAllowedNumbers
            .split(separator: ";")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        guard allowedNumbers.contains(phoneNumber) else {
            return false
        }
        
        // Validate PIN
        guard pinString == settingsManager.settings.smsRemotePIN else {
            return false
        }
        
        // Parse amount
        guard let amount = Decimal(string: amountString) else {
            return false
        }
        
        // Check max bolus limit
        let maxBolus = settingsManager.settings.smsRemoteMaxBolus
        guard amount > 0 && amount <= maxBolus else {
            return false
        }
        
        // Enact bolus
        apsManager.enactBolus(amount: amount, isSMB: false)
        
        return true
    }
} 