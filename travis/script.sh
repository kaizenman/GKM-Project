#!/bin/bash

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
    cp -vf /Projects/app/build/outputs/apk/release/app-release.apk /Projects/bin
    # Building Linux OpenGL app
    filename='run_linux'
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
fi