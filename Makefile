.PHONY: build release

all: run

FILES = Accounts.swift Base32.swift Totp.swift Cli.swift main.swift

run:
	(cd OTP && cat  $(FILES) | \
	swift - central \
	--accounts=$(HOME)/Library/Containers/self.otp/Data/Accounts.json)

release: clean build
	-rm -rf release
	mkdir release
	cp -r build/Release/OTP.app release
	
build:
	xcodebuild

clean:
	-rm -rf build

