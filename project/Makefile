all: run

FILES = Accounts.swift Base32.swift Totp.swift Cli.swift main.swift

run:
	(cd OTP && cat  $(FILES) | \
	swift - central \
	--accounts=$(HOME)/Library/Containers/self.otp/Data/Accounts.json)

