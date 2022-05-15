win:
	flutter clean
	flutter pub get
	flutter build windows

macos:
	flutter clean
	flutter pub get
	flutter build macos
	mv build/macos/Build/Products/Release/ download/macos/