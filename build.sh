#!/bin/bash

# Replace these values with your own
APP_NAME="MyApp"
ICON_PATH="path/to/myapp.icns"
IDENTIFIER="com.example.myapp"
RESOURCES=("path/to/resource1" "path/to/resource2")

# Install cargo-bundle if necessary
if ! command -v cargo-bundle &> /dev/null; then
    cargo install cargo-bundle
fi

# Add the bundle section to Cargo.toml
rm Cargo.toml
touch Cargo.toml
cat << EOF >> Cargo.toml

[package]
name = "gtk4_osx_app_skeleton"
version = "0.1.0"
edition = "2021"

# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html

[dependencies]
gtk4 = "0.6.4"

[package.metadata.bundle]
name = "HelloWorld"
identifier = "com.doe.exampleapplication"
icon = ["32x32.png", "128x128.png", "128x128@2x.png"]
version = "1.0.0"
resources = ["assets", "images/**/*.png", "secrets/public_key.txt"]
copyright = "Copyright (c) Jane Doe 2016. All rights reserved."
category = "Developer Tool"
short_description = "An example application."
long_description = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
eiusmod tempor incididunt ut labore et dolore magna aliqua.  Ut
enim ad minim veniam, quis nostrud exercitation ullamco laboris
nisi ut aliquip ex ea commodo consequat.
"""
deb_depends = ["libgl1-mesa-glx", "libsdl2-2.0-0 (>= 2.0.5)"]
osx_frameworks = ["SDL2"]
osx_url_schemes = ["com.doe.exampleapplication"]
EOF

if [[ ${#RESOURCES[@]} -ne 0 ]]; then
    echo "resources = [" >> Cargo.toml
    for resource in "${RESOURCES[@]}"; do
        echo "\"$resource\"," >> Cargo.toml
    done
    echo "]" >> Cargo.toml
fi

# Build the Rust executable
cargo build --release

# Bundle the Rust executable into a macOS app
cargo bundle --release --target x86_64-apple-darwin

# Open the macOS app bundle in Finder
open "target/bundle/$APP_NAME.app"
