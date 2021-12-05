# Finn The Human

## Android

To make sure your app is optimized for each platform, android provides 2 methods:

1. You can split your app into multiple APKs optimized for each platform.

`flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi`

2. Create an app-bundle and deploy it to play store, this way when a user downloads your app, play store automatically extracts and provides the APK which is optimized for that device.

`flutter build appbundle --target-platform android-arm,android-arm64,android-x64`

To obfuscate

`flutter build appbundle --target-platform android-arm,android-arm64,android-x64 --obfuscate --split-debug-info=./build/app/outputs/symbols`

## iOS

`flutter build ios --release`
