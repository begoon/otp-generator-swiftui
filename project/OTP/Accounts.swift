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

let fileName = "Accounts.json"

func loadAccounts() -> String {
    let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
    let fileURL = homeDirectory.appendingPathComponent(fileName)
    NSLog("loading accounts from %@", fileURL.absoluteString)
    guard let content = try? String(contentsOf: fileURL) else { return "" }
    NSLog("loaded accounts: %@", content)
    return content
}

func accounts() -> Accounts {
    return parseAccounts(from: loadAccounts())
}
