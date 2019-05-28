export GRADLE_VERSION=4.10
export KOTLIN_VERSION=1.2.61
export ANDROID_SDK_VERSION=4333796
export ANDROID_HOME /opt/android-sdk
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export GRADLE_HOME=/opt/gradle
export KOTLIN_HOME=/opt/kotlinc
export PATH=${PATH}:${GRADLE_HOME}/bin:${KOTLIN_HOME}/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin
export _JAVA_OPTIONS=-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap
export PATH=/usr/bin/clang++-6.0/bin:$PATH 
export LD_LIBRARY_PATH=/usr/lib/clang/6.0/lib:$LD_LIBRARY_PATH