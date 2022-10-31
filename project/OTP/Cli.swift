func cli() {
    print(accounts)
    let name = CommandLine.arguments[1]
    guard let account = (accounts.first { account in account.label == name }) else {
        print("account", name, "not found")
        return
    }
    print(account)
    print(totp(secret: account.secret, format: account.format))
}
