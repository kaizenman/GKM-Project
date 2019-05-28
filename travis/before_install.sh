#!/bin/bash

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    dpkg --add-architecture i386
    apt-get update -y
    apt-get install -y libncurses5:i386 libc6:i386 libstdc++6:i386 lib32gcc1 lib32ncurses5 lib32z1 zlib1g:i386
    apt-get install -y --no-install-recommends openjdk-8-jdk
    apt-get install -y git wget zip
    apt-get install -y qt5-default

    # download and install Gradle
    # https://services.gradle.org/distributions/
    export GRADLE_VERSION=4.10
    cd /opt
    wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
    unzip gradle*.zip
    ls -d */ | sed 's/\/*$//g' | xargs -I{} mv {} gradle
    rm gradle*.zip

    # download and install Kotlin compiler
    # https://github.com/JetBrains/kotlin/releases/latest
    export KOTLIN_VERSION=1.2.61
    cd /opt
    wget -q https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip
    unzip *kotlin*.zip
    rm *kotlin*.zip

    # download and install Android SDK
    # https://developer.android.com/studio/#downloads
    export ANDROID_SDK_VERSION=4333796
    mkdir -p /opt/android-sdk && cd /opt/android-sdk
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip
    unzip *tools*linux*.zip
    rm *tools*linux*.zip

    # set the environment variables
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
    export GRADLE_HOME=/opt/gradle
    export KOTLIN_HOME=/opt/kotlinc
    export ANDROID_HOME=/opt/android-sdk
    export PATH=${PATH}:${GRADLE_HOME}/bin:${KOTLIN_HOME}/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin
    export _JAVA_OPTIONS=-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap

    apt-get update -y
    yes | sdkmanager --licenses
    sdkmanager "ndk-bundle"
    apt-get -y install cmake
    apt-get install ninja-build
    apt-get -y install software-properties-common

    apt-get dist-upgrade -y
    echo "deb http://ftp.us.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list.d/jessie.list
    echo "deb http://ftp.us.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list.d/unstable.list
    apt-get update
    apt install python -y
    apt install python3 -y
    apt-get install -y g++-4.9 g++-8
    apt-get install -y clang++-6.0
    apt-get install libc++-dev -y
    apt-get install libc++abi-dev -y
    apt-get autoremove --purge -y
    apt-get autoclean -y
    rm -rf /var/cache/apt/* /tmp/*
    echo "Setting g++ 8 as default compiler"
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 1
    echo "Setting python3 as default"
    update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
    update-alternatives --install /usr/bin/python python /usr/bin/python2.7 2
    echo "Getting polly..."
    wget --no-check-certificate -O v0.10.3.tar.gz https://github.com/ruslo/polly/archive/v0.10.3.tar.gz
    tar xvzf v0.10.3.tar.gz
    echo "Setting environment variables"
    echo "... Adding /usr/bin/clang++-6.0/bin to PATH variable"
    export PATH=/usr/bin/clang++-6.0/bin:$PATH
    echo "... Adding /usr/lib/clang/6.0/lib to LD_LIBRARY_PATH variable"
    export LD_LIBRARY_PATH=/usr/lib/clang/6.0/lib:$LD_LIBRARY_PATH
    ln -s /usr/bin/clang++-6.0 /usr/bin/clang++
    ln -s /usr/bin/clang-6.0 /usr/bin/clang
    echo "... Adding /polly-0.10.3 to POLLY_ROOT variable"
    export POLLY_ROOT=/polly-0.10.3
    echo "... Getting opengl libraries"
    echo "test"
    wget --no-check-certificate -O opengl_deps.tar.gz  https://github.com/kaizenman/utils/archive/opengl_deps.tar.gz
    tar xvzf opengl_deps.tar.gz
    chmod +x ./utils-opengl_deps/install_opengl_deps.sh
    ./utils-opengl_deps/install_opengl_deps.sh
fi