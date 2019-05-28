#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    brew install glfw3
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    source travis/vars.sh
  
    dpkg --add-architecture i386 > /dev/null 2>&1
    apt-get update -y > /dev/null 2>&1
    apt-get install -y libncurses5:i386 libc6:i386 libstdc++6:i386 lib32gcc1 lib32ncurses5 lib32z1 zlib1g:i386 > /dev/null 2>&1
    apt-get install -y --no-install-recommends openjdk-8-jdk > /dev/null 2>&1
    apt-get install -y git wget zip > /dev/null 2>&1
    apt-get install -y qt5-default > /dev/null 2>&1
    cd /opt
    wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip > /dev/null 2>&1
    unzip gradle*.zip
    ls -d */ | sed 's/\/*$//g' | xargs -I{} mv {} gradle
    rm gradle*.zip

    cd /opt
    wget -q https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip > /dev/null 2>&1
    unzip *kotlin*.zip
    rm *kotlin*.zip

    mkdir -p ${ANDROID_HOME} && cd ${ANDROID_HOME}
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip > /dev/null 2>&1
    unzip *tools*linux*.zip > /dev/null 2>&1
    rm *tools*linux*.zip > /dev/null 2>&1

    apt-get update -y > /dev/null 2>&1
    yes | sdkmanager --licenses > /dev/null 2>&1
    sdkmanager "ndk-bundle" > /dev/null 2>&1
    apt-get -y install cmake
    apt-get -y install ninja-build
    apt-get -y install software-properties-common > /dev/null 2>&1
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
    apt-get update
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-6.0 main"
    apt-get install -y clang-6.0 lld-6.0

    apt-get dist-upgrade -y > /dev/null 2>&1
    echo "deb http://ftp.us.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list.d/jessie.list
    echo "deb http://ftp.us.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list.d/unstable.list
    apt-get update > /dev/null 2>&1
    apt install python -y > /dev/null 2>&1
    apt install python3 -y > /dev/null 2>&1
    apt-get install -y g++-4.9 g++-8 > /dev/null 2>&1
    apt-get install -y clang++-6.0 > /dev/null 2>&1
    apt-get install libc++-dev -y > /dev/null 2>&1
    apt-get install libc++abi-dev -y > /dev/null 2>&1
    apt-get autoremove --purge -y > /dev/null 2>&1
    apt-get autoclean -y > /dev/null 2>&1
    rm -rf /var/cache/apt/* /tmp/* > /dev/null 2>&1
    
    
    echo "Setting g++ 8 as default compiler"
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 1 > /dev/null 2>&1
    echo "Setting python3 as default"
    update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1 > /dev/null 2>&1
    update-alternatives --install /usr/bin/python python /usr/bin/python2.7 2 > /dev/null 2>&1
    #echo "Getting polly..."
    #wget --no-check-certificate -O v0.10.3.tar.gz https://github.com/ruslo/polly/archive/v0.10.3.tar.gz
    #tar xvzf v0.10.3.tar.gz
    echo "Setting environment variables"
    echo "... Adding /usr/bin/clang++-6.0/bin to PATH variable"
    echo "... Adding /usr/lib/clang/6.0/lib to LD_LIBRARY_PATH variable"
    ln -s /usr/bin/clang++-6.0 /usr/bin/clang++
    ln -s /usr/bin/clang-6.0 /usr/bin/clang
    #echo "... Adding /polly-0.10.3 to POL\LY_ROOT variable"
    #export POLLY_ROOT=/polly-0.10.3
    echo "... Getting opengl libraries"
    echo "Installing RANDR!!!"
  #  apt-get update
  #  git clone https://github.com/glfw/glfw
  #  cd glfw
  #  mkdir build
  #  cd build
  #  yes | apt-get install xorg-dev libglu1-mesa-dev libgl1-mesa-dev freeglut3-dev
    # TODO find out why RANDR is still missing on linux
    #cmake .. && make -j4
    #make install

  #  cd ..
  #  cd ..

  #if [ ! -d "./include" ]; then
  # mkdir ./include
  #fi

  #cp -Rv ./glfw/include/ ./include/ 
  #rm -r glfw
fi