# OTP Generator in SwiftUI

This application helps calculate one-time-passwords (TOTP).

The user configures profiles with secrets and templates to build the passwords. The application puts a generated password to the clipboard so the user can paste it to other applications.

First, the application needs to build. The required software is Xcode 14 (with support for macOS 13 Ventura).

After checking out the repository to a local directory, the "make release" command should be executed from that directory.

The "release" subdirectory will contain "OTP.app", the standard macOS application bundle, which can be copied to Applications, and started.

Second, the application requires the configuration file with secrets. The configuration file is expected to be named `$HOME/.otp/Accounts.json`.

The example of "Accounts.json":

```json
[
    {
        "label": "central",
        "secret": "DRFC7I3I6B2F4CCP",
        "format": "123456<@>"
    }
]
```

This file contains one account named "central". The secret (one-time password secret) is "DRFC7I3I6B2F4CCP" (base32), and the template to generate the generated password is "123456<@>". The password will be a concatenation of "123456" and the actual TOTP, for example, "123456410449".

The configuration file can contain multiple accounts.

When the application starts and the configuration is created, the following icon should be available in the top tray menu.

![image](https://user-images.githubusercontent.com/84461/203825019-e88559ae-0777-43a5-9c45-63031abbc441.png)

The configuration file is either not found or incorrect if only Reload and Quit items are in the menu.

The Reload item forces the application to re-read the configuration without restarting the application entirely. 
