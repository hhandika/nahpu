## Various build scripts for the project
import subprocess
import argparse
import platform
import os

DART_FRB = "lib/src/rust/frb_generated.dart"
DART_FRB_IO = "lib/src/rust/frb_generated.io.dart"
DART_FRB_WEB = "lib/src/rust/frb_generated.web.dart"
RUST_FRB_IO = "rust/src/frb_generated.io.rs"
RUST_FRB = "rust/src/frb_generated.rs"
RUST_FRB_WEB = "rust/src/frb_generated.web.rs"

FRB_FILES = [
    DART_FRB, DART_FRB_IO, DART_FRB_WEB,
    RUST_FRB_IO, RUST_FRB, RUST_FRB_WEB
]

DMG_CONFIG = "installer/config.json"
OUTPUT_DMG = "installer/nahpu.dmg"

class Build:
    def __init__(self):
        pass

    def build_all(self) -> None:
        os_name: str = platform.system()
        print(f"Building for all platforms on {os_name}...")
        try:
            if platform.system() == "Windows":
                self.build_windows()
            elif platform.system() == "Darwin":
                self.build_ios()
                self.build_macos()
            elif platform.system() == "Linux":
                self.build_linux()
            else:
                print("Unsupported platform")
            
        except:
            print("Error building project for all platforms")
            
    def build_apk(self) -> None:
        print("Building for Android...")
        try:
            subprocess.run(["flutter", "build", "apk", "--release"])
            print("Project built successfully\n")
        except:
            print("Error cleaning project for android")

    def build_ios(self) -> None:
        print("Building for iOS...")
        try:
            subprocess.run(["flutter", "build", "ios", "--release"])
            print("Project built successfully\n")
        except:
            print("Error building project for ios")

    def build_macos(self) -> None:
        print("Building for macOS...")
        try:
            subprocess.run(["flutter", "build", "macos", "--release"])
            print("Project built successfully\n")
            self._remove_dmg()
            self._create_dmg()
            self._open_dmg()
        except:
            print("Error building project for macos")
            
    def build_linux(self) -> None:
        print("Building for Linux...")
        try:
            subprocess.run(["flutter", "build", "linux", "--release"])
            print("Project built successfully\n")
        except:
            print("Error building project for linux")

    def build_windows(self) -> None:
        print("Building for Windows...")
        try:
            subprocess.run(["flutter", "build", "windows", "--release"])
            print("Project built successfully\n")

        except:
            print("Error building project for windows")
            return
    
    def _create_dmg(self) -> None:
        print("Creating dmg...")
        try:
            subprocess.run(["appdmg", DMG_CONFIG, OUTPUT_DMG])
            print("Dmg created successfully\n")
        except:
            print("Error creating dmg")
    
    def _remove_dmg(self) -> None:
        print("Removing dmg...")
        try:
            if os.path.exists(OUTPUT_DMG):
                os.remove(OUTPUT_DMG)
                print("Dmg removed successfully\n")
        except:
            print("Error removing dmg")
    
    def _open_dmg(self) -> None:
        print("Opening dmg...")
        try:
            subprocess.run(["open", OUTPUT_DMG])
            print("Dmg opened successfully\n")
        except:
            print("Error opening dmg")
    

class FlutterUtils:
    def __init__(self):
        pass

    def clean_project(self) -> None:
        print("Cleaning project...")
        try:
            subprocess.run(["flutter", "clean"])
            print("Project cleaned successfully\n")
        except:
            print("Error cleaning project")
            return
    
    def fix_dart_code(self) -> None:
        print("Fixing dart code...")
        try:
            subprocess.run(["dart", "fix", "--apply"])
            print("Dart code fixed successfully\n")
        except:
            print("Error fixing dart code")
            return
    
    def update_flutter_dependencies(self) -> None:
        print("Updating flutter dependencies...")
        try:
            subprocess.run(["flutter", "pub", "upgrade"])
            print("Flutter dependencies updated successfully\n")
        except:
            print("Error updating flutter dependencies")
            return

class BuildRust:
    def __init__(self):
        pass
    
    def generate_frb_code(self) -> None:
        print("Generating frb code...")
        try:
            self.remove_old_frb_code()
            subprocess.run(["flutter_rust_bridge_codegen", "generate"])
            print("Rust code generated successfully\n")
        except:
            print("Error generating frb code")
            return

    def remove_old_frb_code(self) -> None:
        print("Removing old frb code...")
        try:
            for file in FRB_FILES:
                if os.path.exists(file):
                    os.remove(file)
                    print(f"Removed {file}")
            print("Old frb code removed successfully\n")
        except:
            print("Error removing old frb code")
            return

    def check_rust_dependencies(self) -> None:
        print("Checking rust dependencies...")
        try:
            subprocess.run(["cargo", "check"], cwd="rust")
            print("Rust dependencies checked successfully\n")
        except:
            print("Error checking rust dependencies")
            return
    
    def update_rust_dependencies(self) -> None:
        print("Updating rust dependencies...")
        try:
            subprocess.run(["cargo", "update"], cwd="rust")
            print("Rust dependencies updated successfully\n")
        except:
            print("Error updating rust dependencies")
            return
        
class Args:
    def __init__(self):
        pass
    
    def get_args(self) -> argparse.Namespace:
        parser = argparse.ArgumentParser(description="Various build scripts for the project")
        subparsers = parser.add_subparsers(dest="command", help="Commands for build scripts")
        self.get_flutter_build_args(subparsers)
        self.get_flutter_utils_args(subparsers)
        self.get_rust_build_args(subparsers)
    
        return parser.parse_args()

    def get_flutter_build_args(self, args: argparse.Namespace) -> None:
        parser = args.add_parser("build", help="Build project")
        parser.add_argument("--apk", action="store_true", help="Build apk")
        parser.add_argument("--ios", action="store_true", help="Build ios")
        parser.add_argument("--macos", action="store_true", help="Build macos")
        parser.add_argument("--linux", action="store_true", help="Build linux")
        parser.add_argument("--all", action="store_true", help="Build all platforms")
    
    def get_flutter_utils_args(self, args: argparse.Namespace) -> None:
        parser = args.add_parser("utils", help="Utilities for Flutter project")
        parser.add_argument("--clean", action="store_true", help="Clean project")
        parser.add_argument("--fix", action="store_true", help="Fix dart code")
        parser.add_argument("--update", action="store_true", help="Update flutter dependencies")
    
    def get_rust_build_args(self, args: argparse.Namespace) -> None:
        parser = args.add_parser("frb", help="Build options for Rust project")
        parser.add_argument("--generate", action="store_true", help="Generate frb code")
        parser.add_argument("--check", action="store_true", help="Check rust dependencies")
        parser.add_argument("--update", action="store_true", help="Update rust dependencies")

class Parser:
    def __init__(self, args: argparse.Namespace):
        self.args = args

    def parse_build_args(self) -> None:
        build = Build()
        if self.args.apk:
            build.build_apk()
        elif self.args.ios:
            build.build_ios()
        elif self.args.macos:
            build.build_macos()
        elif self.args.linux:
            build.build_linux()
        elif self.args.all:
            build.build_all()
        else:
            print("No platform selected")
    
    def parse_flutter_utils_args(self) -> None:
        utils = FlutterUtils()
        if self.args.clean:
            utils.clean_project()
        elif self.args.fix:
            utils.fix_dart_code()
        elif self.args.update:
            utils.update_flutter_dependencies()
        else:
            print("No utility option selected")
            return
    
    def parse_rust_build_args(self) -> None:
        rust = BuildRust()
        if self.args.generate:
            rust.generate_frb_code()
        elif self.args.check:
            rust.check_rust_dependencies()
        elif self.args.update:
            rust.update_rust_dependencies()
        else:
            print("No build option selected")
            return
    
def main() -> None:
    args = Args().get_args()
    parser = Parser(args)
    if args.command == "build":
        parser.parse_build_args()
    elif args.command == "utils":
        parser.parse_flutter_utils_args()
    elif args.command == "frb":
        parser.parse_rust_build_args()
    else:
        print("No command selected")
    
if __name__ == "__main__":
    main()