import SwiftUI

@main
struct OTPApp: App {
    struct IdentifiableAccount: Identifiable {
        let id = UUID()
        let index: Int
        let account: Account
    }

    let shortcuts: String = "123456789abcdefhijklmnopqrstuvwxyz"

    func shortcut(index: Int) -> Character {
        guard index < shortcuts.count else { return " " }
        return Array(shortcuts)[index]
    }

    @State private var id = 0

    var body: some Scene {
        MenuBarExtra("-", systemImage: "key.horizontal.fill") {
            let accounts = accounts()
            ForEach(accounts.enumerated().map {IdentifiableAccount(index: $0, account: $1)}) {
                element in Button(element.account.label) {
                    NSPasteboard.general.clearContents()
                    let account = element.account
                    let password = totp(secret: account.secret, format: account.format)
                    print(NSPasteboard.general.setString(password, forType: .string))
                }
                .keyboardShortcut(KeyboardShortcut(KeyEquivalent(shortcut(index: element.index))))
            }
            Divider()
            Button("Reload") {
                id += 1
            }.id(id)
            .keyboardShortcut("r")
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}
