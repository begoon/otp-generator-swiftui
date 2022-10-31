import Foundation

struct Account: Codable {
    var label: String
    var secret: String
    var format: String
}

typealias Accounts = [Account]

enum ParseError: Error {
    case invalidUTF8(text: String)
    case invalidFileName(name: String)
    case invalidFile(url: URL)
}

func parseAccounts(from text: String) throws -> Accounts {
    guard let data = text.data(using: .utf8) else {
        throw ParseError.invalidUTF8(text: text)
    }
    return (try? JSONDecoder().decode(Accounts.self, from: data)) ?? []
}

let defaultFileName = ".otp/Accounts.json"
let defaultFileURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(
    defaultFileName
)

func accountsFileName(from fileName: String = "") throws -> URL {
    var fileURL: URL = defaultFileURL
    if !fileName.isEmpty {
        guard let url = URL(string: "file://" + fileName) else {
            throw ParseError.invalidFileName(name: fileName)
        }
        fileURL = url
    }
    NSLog("loading accounts from %@", fileURL.absoluteString)
    return fileURL
}

func loadAccounts(from fileName: String = "") throws -> String {
    let fileURL = try accountsFileName(from: fileName)
    guard let content = try? String(contentsOf: fileURL) else {
        throw ParseError.invalidFile(url: fileURL)
    }
    NSLog("loaded accounts: %@", content)
    return content
}

func accounts(from fileName: String = "") -> Accounts {
    do {
        let content = try loadAccounts(from: fileName)
        return try parseAccounts(from: content)
    } catch ParseError.invalidUTF8(let text) {
        NSLog("invalid UTF8 in [%@]", text)
        return []
    } catch ParseError.invalidFileName(let name) {
        NSLog("invalid filename [%@]", name)
    } catch ParseError.invalidFile(let url) {
        NSLog("unable to load from [%@]", url.description)
    } catch {
        print("Unexpected error: \(error).")
    }
    return []
}
