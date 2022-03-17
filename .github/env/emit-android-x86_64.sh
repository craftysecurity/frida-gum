#!/bin/sh

pkgconfig=$1
needs_exe_wrapper=$2

bindir=$ANDROID_NDK_LATEST_HOME/toolchains/llvm/prebuilt/$(uname -s | tr '[A-Z]' '[a-z]')-$(uname -m)/bin

cat << EOF
[constants]
c_like_flags = ['-DANDROID', '-ffunction-sections', '-fdata-sections']
linker_flags = ['-Wl,--gc-sections', '-Wl,-z,noexecstack', '-Wl,-z,relro', '-Wl,-z,now']

[binaries]
c = '$bindir/x86_64-linux-android21-clang'
cpp = '$bindir/x86_64-linux-android21-clang++'
strip = '$bindir/llvm-strip'
pkgconfig = '$pkgconfig'

[built-in options]
c_args = c_like_flags
cpp_args = c_like_flags
c_link_args = linker_flags
cpp_link_args = linker_flags + ['-static-libstdc++']

[host_machine]
system = 'android'
cpu_family = 'x86_64'
cpu = 'x86_64'
endian = 'little'

[properties]
needs_exe_wrapper = $needs_exe_wrapper
EOF
