#!/bin/sh
# Get Xcode major version
# `xcodebuild -version` returns something like:
# Xcode 26.0.1
# Build version 17A400
XCODE_VERSION=$(xcodebuild -version | head -n 1 | awk '{print $2}' | cut -d. -f1)
 
if [ "$XCODE_VERSION" -ge 26 ]; then
    if xcodebuild -showComponent metalToolchain >/dev/null 2>&1; then
        echo "Metal toolchain is installed"
    else
        echo "Metal toolchain is not installed. Failing the build."
        exit 1
    fi
fi

export TOOLCHAINS=default
