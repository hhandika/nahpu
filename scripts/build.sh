#!/bin/bash

echo "Build options:"
PS3='Please select the platform: '
OPT=("Android" "iOS" "MacOS" "All" "Quit")
OUTPUT_DIR="../NahpuReleases"

create_output_dir() {
    if [ ! -d $OUTPUT_DIR ]; then
        mkdir output
    fi
}

move_apk() {
    if [ -f "build/app/outputs/apk/release/app-release.apk" ]; then
        echo "Moving APK to $OUTPUT_DIR"
        mv build/app/outputs/apk/release/app-release.apk $OUTPUT_DIR
    fi
}

move_dmg() {
    if [ -f "installer/nahpu.dmg" ]; then
        echo "Moving DMG to $OUTPUT_DIR"
        mv installer/nahpu.dmg $OUTPUT_DIR
    fi
}

move_all() {
    move_apk
    move_dmg
}

select os in "${OPT[@]}"

do
    case $os in
        "Android")
            echo "Building for Android..."
            flutter build apk --release
            move_apk
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
            move_dmg
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
            move_all
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $os";;
    esac
done