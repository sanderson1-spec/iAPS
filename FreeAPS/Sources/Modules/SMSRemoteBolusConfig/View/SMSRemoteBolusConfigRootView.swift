import SwiftUI
import Swinject

struct SMSRemoteBolusConfigRootView: BaseView {
    let resolver: Resolver
    @StateObject var state = SMSRemoteBolusConfigStateModel()
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }
    
    var body: some View {
        Form {
            Section(header: Text("SMS Remote Bolus")) {
                Toggle("Enable SMS Remote Bolus", isOn: $state.isEnabled)
                
                if state.isEnabled {
                    HStack {
                        Text("Allowed Phone Numbers")
                        Spacer()
                        TextField("", text: $state.allowedPhoneNumbers)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.primary)
                            .keyboardType(.numbersAndPunctuation)
                    }
                    
                    HStack {
                        Text("Security PIN")
                        Spacer()
                        SecureField("", text: $state.securityPIN)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.primary)
                            .keyboardType(.numbersAndPunctuation)
                    }
                    
                    HStack {
                        Text("Maximum Bolus")
                        Spacer()
                        DecimalTextField("", value: $state.maxBolusAmount, formatter: formatter)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.primary)
                            .keyboardType(.decimalPad)
                    }
                    
                    NavigationLink(destination: SMSRemoteBolusConfigSetupGuideView()) {
                        Text("View Setup Guide")
                    }
                }
            }
            
            if state.isEnabled {
                Section(header: Text("Instructions")) {
                    Text("To trigger a remote bolus, send an SMS from an allowed phone number with the format: BOLUS [AMOUNT] [PIN]")
                        .font(.footnote)
                    
                    Text("Example: BOLUS 1.5 1234")
                        .font(.footnote)
                    
                    Text("Note: You will need to create an Apple Shortcut to process SMS messages and trigger the bolus in iAPS.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .onAppear(perform: configureView)
        .navigationTitle("SMS Remote Bolus")
    }
} 