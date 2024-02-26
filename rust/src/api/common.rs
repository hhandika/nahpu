use nahpu_api::test_lib;

#[flutter_rust_bridge::frb(sync)]
pub fn test_rust() -> String {
    test_lib()
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
