#!/bin/bash

echo "Build options:"
PS3='Please select the platform: '
OPT=("Android" "iOS" "MacOS" "All" "Quit")

select os in "${OPT[@]}"

do
    case $os in
        "Android")
            echo "Building for Android..."
            flutter build apk --release
            break
            ;;
        "iOS")
            echo "Building for iOS..."
            flutter build ios --release
            break
            ;;
        "MacOS")
            echo "Building for MacOS..."
            flutter build macos --release
            echo "Creating DMG installer..."
            scripts/build_dmg.sh
            break
            ;;
        "All")
            echo "Building for all platforms..."
            echo "Building for Android..."
            flutter build apk --release
            echo "Building for iOS..."
            flutter build ios --release
            echo "Building for MacOS..."
            flutter build macos --release
            echo "Creating DMG installer..."
            scripts/build_dmg.sh
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $os";;
    esac
done