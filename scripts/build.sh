#!/bin/bash

echo "Build options:"
PS3='Please select the platform: '
OPT=("Android" "iOS" "MacOS" "All" "Quit")
OUTPUT_DIR="../nahpu-releases"

create_output_dir() {
    if [ ! -d $OUTPUT_DIR ]; then
        mkdir $OUTPUT_DIR
    fi
}

copy_apk() {
    create_output_dir
    if [ -f "build/app/outputs/apk/release/app-release.apk" ]; then
        echo "Copying APK to $OUTPUT_DIR"
        cp build/app/outputs/apk/release/app-release.apk $OUTPUT_DIR/nahpu_beta_android.apk
    fi
}

mv_dmg() {
    create_output_dir
    if [ -f "installer/nahpu.dmg" ]; then
        echo "Moving DMG to $OUTPUT_DIR"
        mv installer/nahpu.dmg $OUTPUT_DIR/nahpu_beta_macos.dmg
    fi
}

copy_and_move_all() {
    copy_apk
    mv_dmg
}

select os in "${OPT[@]}"

do
    case $os in
        "Android")
            echo "Building for Android..."
            flutter build apk --release
            copy_apk
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
            mv_dmg
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
            copy_and_move_all
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $os";;
    esac
done