# Build the Rust executable
cargo build --release

# Bundle the Rust executable into a macOS app
cargo bundle --release --target x86_64-apple-darwin

# Open the macOS app bundle in Finder
open "target/bundle/$APP_NAME.app"
