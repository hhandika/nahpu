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

# List frb files
FRB_FILES = [
    DART_FRB, DART_FRB_IO, DART_FRB_WEB,
    RUST_FRB_IO, RUST_FRB, RUST_FRB_WEB
]

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

class FlutterUtils:
    def __init__(self):
        pass

    def clean_project() -> None:
        print("Cleaning project...")
        try:
            subprocess.run(["flutter", "clean"])
            print("Project cleaned successfully\n")
        except:
            print("Error cleaning project")
            return
    
    def fix_dart_code() -> None:
        print("Fixing dart code...")
        try:
            subprocess.run(["dart", "fix", "--apply"])
            print("Dart code fixed successfully\n")
        except:
            print("Error fixing dart code")
            return
    
    def update_flutter_dependencies() -> None:
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

def get_flutter_build_args(args: argparse.Namespace) -> None:
    parser = args.add_parser("build", help="Build project")
    parser.add_argument("--apk", action="store_true", help="Build apk")
    parser.add_argument("--ios", action="store_true", help="Build ios")
    parser.add_argument("--macos", action="store_true", help="Build macos")
    parser.add_argument("--linux", action="store_true", help="Build linux")
    parser.add_argument("--all", action="store_true", help="Build all platforms")

def get_flutter_utils_args(args: argparse.Namespace) -> None:
    parser = args.add_parser("utils", help="Utilities for Flutter project")
    parser.add_argument("--clean", action="store_true", help="Clean project")
    parser.add_argument("--fix", action="store_true", help="Fix dart code")
    parser.add_argument("--update", action="store_true", help="Update flutter dependencies")

def get_rust_build_args(args: argparse.Namespace) -> None:
    parser = args.add_parser("frb", help="Build options for Rust project")
    parser.add_argument("--generate", action="store_true", help="Generate frb code")
    parser.add_argument("--check", action="store_true", help="Check rust dependencies")
    parser.add_argument("--update", action="store_true", help="Update rust dependencies")
    

def get_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Various build scripts for the project")
    subparsers = parser.add_subparsers(dest="command", help="Commands for build scripts")
    get_flutter_build_args(subparsers)
    get_flutter_utils_args(subparsers)
    get_rust_build_args(subparsers)
    
    return parser.parse_args()

def parse_build_args(args: argparse.Namespace) -> None:
    build = Build()
    if args.apk:
        build.build_apk()
    elif args.ios:
        build.build_ios()
    elif args.macos:
        build.build_macos()
    elif args.linux:
        build.build_linux()
    elif args.all:
        build.build_all()
    else:
        print("No platform selected")
        return

def parse_flutter_utils_args(args: argparse.Namespace) -> None:
    if args.clean:
        FlutterUtils.clean_project()
    elif args.fix:
        FlutterUtils.fix_dart_code()
    elif args.update:
        FlutterUtils.update_flutter_dependencies()
    else:
        print("No utility option selected")
        return

def parse_rust_build_args(args: argparse.Namespace) -> None:
    if args.generate:
        BuildRust.generate_frb_code()
    elif args.check:
        BuildRust.check_rust_dependencies()
    elif args.update:
        BuildRust.update_rust_dependencies()
    else:
        print("No build option selected")
        return
    
def main() -> None:
    args = get_args()
    if args.command == "build":
        parse_build_args(args)
    elif args.command == "utils":
        parse_flutter_utils_args(args)
    elif args.command == "frb":
        parse_rust_build_args(args)
    else:
        print("No command selected")
        return
    
if __name__ == "__main__":
    main()