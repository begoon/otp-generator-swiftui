import Foundation

struct Account: Codable {
    var label: String
    var secret: String
    var format: String
}

typealias Accounts = [Account]

func parseAccounts(from text: String) -> Accounts {
    guard let data = text.data(using: .utf8) else { return [] }
    return (try? JSONDecoder().decode(Accounts.self, from: data)) ?? []
}

let fileName = ".otp"

func loadAccounts() -> String {
    let homeDirectory = NSHomeDirectory()
    print(homeDirectory)
    let dir = FileManager.default.homeDirectoryForCurrentUser
    if let home = ProcessInfo.processInfo.environment["HOME"] {
        NSLog("home directory %@", home)
    }
    let fileURL = dir.appendingPathComponent(fileName)
    print(fileURL)
    NSLog("loading accounts from %@", fileURL.absoluteString)
    guard let content = try? String(contentsOf: fileURL) else { return "" }
    print(content)
    return content
}

let accounts = parseAccounts(from: loadAccounts())
