#!/bin/bash

source travis/vars.sh

# ninja
wget https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-linux.zip
mkdir ninja
unzip ninja-linux.zip -d ninja/
ls /home/travis/build/kaizenman/GKM-Project/ninja/
ls /home/travis/build/kaizenman/GKM-Project/ninja/ninja
export PATH=$PATH:/home/travis/build/kaizenman/GKM-Project/ninja/

echo $PWD

which ninja
echo $PATH

filename='unknown'
if [ "$(uname)" == "Darwin" ]; then
    # Building MacOS X OpenGL app
    filename='run_darwin'
    if [ ! -d "build" ]; then
        mkdir build
    fi
    cd build
    cmake ..
    make
    cd ..
    if [ ! -d "bin" ]; then
    mkdir bin
    fi
    cp -vf build/bin/"$filename" bin/"$filename"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    filename='app-release.apk'
    # Building Android OpenGL app
    ./gradlew assembleRelease

    if [ ! -d "bin" ]; then
        mkdir bin
    fi

    cp -vf app/build/outputs/apk/release/app-release.apk bin/
    # Building Linux OpenGL app
    # TODO find out why RANDR is still missing
    #filename='run_linux'
    #if [ ! -d "build" ]; then
        #mkdir build
    #fi
    #cd build
    #cmake ..
    #make
    #cd ..
    #if [ ! -d "bin" ]; then
    #mkdir bin
    #fi
    #cp -vf build/bin/"$filename" bin/"$filename"
fi