import Foundation
import SwiftUI

final class SMSRemoteBolusConfigStateModel: BaseStateModel<SMSRemoteBolusConfigProvider> {
    @Injected() private var settingsManager: SettingsManager!
    
    @Published var allowedPhoneNumbers: String = ""
    @Published var securityPIN: String = ""
    @Published var maxBolusAmount: Decimal = 0.0
    @Published var isEnabled: Bool = false
    
    override func subscribe() {
        allowedPhoneNumbers = settingsManager.settings.smsRemoteAllowedNumbers
        securityPIN = settingsManager.settings.smsRemotePIN
        maxBolusAmount = settingsManager.settings.smsRemoteMaxBolus
        isEnabled = settingsManager.settings.smsRemoteEnabled
        
        subscribeSetting(\.smsRemoteAllowedNumbers, on: $allowedPhoneNumbers) { allowedPhoneNumbers = $0 }
        subscribeSetting(\.smsRemotePIN, on: $securityPIN) { securityPIN = $0 }
        subscribeSetting(\.smsRemoteMaxBolus, on: $maxBolusAmount) { maxBolusAmount = $0 }
        subscribeSetting(\.smsRemoteEnabled, on: $isEnabled) { isEnabled = $0 }
    }
} 