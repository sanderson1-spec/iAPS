import SwiftUI

struct SMSRemoteBolusConfigSetupGuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Setting up SMS Remote Bolus")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                
                Text("SMS Remote Bolus allows you to trigger a bolus by sending an SMS message from an authorized phone number. This is useful for caregivers or for yourself when you can't access your phone directly.")
                    .font(.body)
                
                Text("Step 1: Configure iAPS")
                    .font(.headline)
                
                Text("• Enable SMS Remote Bolus in the settings\n• Add your trusted phone numbers (separate multiple numbers with semicolons)\n• Set a secure PIN code\n• Set a maximum bolus amount for safety")
                    .font(.body)
                
                Text("Step 2: Create an Apple Shortcut")
                    .font(.headline)
                
                Text("Since iOS doesn't allow apps to directly read SMS messages, you'll need to create an Apple Shortcut to process incoming messages:")
                    .font(.body)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("1. Open the Shortcuts app")
                    Text("2. Create a new Personal Automation")
                    Text("3. Select 'Message' as the trigger")
                    Text("4. Set 'Message Contains' to 'BOLUS'")
                    Text("5. Select 'From' and add the same phone numbers you authorized in iAPS")
                    Text("6. Tap 'Next' and add the following actions:")
                    Text("   • 'Match Text' with regex pattern: BOLUS (\\d+(\\.\\d+)?) (\\d+)")
                    Text("   • 'Get Group from Matched Text' - Group 1 for the amount")
                    Text("   • 'Get Group from Matched Text' - Group 3 for the PIN")
                    Text("   • 'Get Sender' to get the phone number")
                    Text("   • 'URL' action with: iaps://smsremotebolus?amount=[Shortcut Magic Variable for amount]&pin=[Shortcut Magic Variable for PIN]&phone=[Shortcut Magic Variable for phone number]")
                    Text("   • 'Open URLs' action")
                    Text("7. Turn off 'Ask Before Running'")
                    Text("8. Save the shortcut")
                }
                .font(.body)
                
                Text("Step 3: Test the Setup")
                    .font(.headline)
                
                Text("Send an SMS from an authorized phone number with the format:")
                    .font(.body)
                
                Text("BOLUS [AMOUNT] [PIN]")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
                
                Text("Example: BOLUS 1.5 1234")
                    .font(.body)
                    .italic()
                
                Text("Security Notes")
                    .font(.headline)
                    .padding(.top, 8)
                
                Text("• Only authorized phone numbers can trigger a bolus\n• The PIN code provides an additional layer of security\n• The maximum bolus setting prevents accidental large doses\n• All remote bolus actions are logged in iAPS")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Setup Guide")
    }
} 