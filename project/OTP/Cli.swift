import Foundation

let fileNameFlagPrefix = "--accounts="

func cli() {
    if CommandLine.arguments.count < 2 {
        let exe = CommandLine.arguments[0]
        print("usage \(exe) account [--accounts=filename.json]")
        return
    }
    
    let label = CommandLine.arguments[1]

    var fileName = String()

    if let flag = CommandLine.arguments.first(where: { value in
        value.starts(with: fileNameFlagPrefix)
    }) {
        fileName = String(flag.suffix(flag.count - fileNameFlagPrefix.count))
    }

    let accounts = accounts(from: fileName)

    guard let account = (accounts.first { account in account.label == label }) else {
        NSLog("account [%@] not found", label)
        return
    }

    print(account)

    print(totp(secret: account.secret, format: account.format))
}
