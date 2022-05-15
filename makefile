win:
	flutter clean
	flutter pub get
	flutter build windows

build:
	flutter clean
	flutter pub get
	flutter build macos
	rm -R download/macos/Release
	mv build/macos/Build/Products/Release/ download/macos/
	open download/macos/Release/grpc_clicker.app