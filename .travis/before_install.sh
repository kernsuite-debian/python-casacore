#!/usr/bin/env bash

set -e
set -v

if [ "$TRAVIS_OS_NAME" = linux ]; then
    sudo apt-get update 
    sudo apt-get install -y software-properties-common python-setuptools libboost-python-dev libcfitsio3-dev
    sudo add-apt-repository -y ppa:radio-astro/main
    sudo add-apt-repository -y "deb http://us.archive.ubuntu.com/ubuntu $(lsb_release -sc) restricted multiverse"
    sudo apt-get update 
    if [ "$CASACORE" = 20 ]; then
        sudo apt-get install -y libcasacore2-dev casacore-data
    elif [ "$CASACORE" = 21 ]; then
        sudo apt-get install -y libcasacore21-dev casacore-data
    fi
fi

if [ "$TRAVIS_OS_NAME" = osx ]; then
    brew update > /dev/null
    brew tap homebrew/science
    brew tap ska-sa/tap
    brew install cfitsio wcslib fftw hdf5 ccache
    curl -L -O https://bintray.com/artifact/download/casacore/homebrew-bottles/boost-python-1.60.0.el_capitan.bottle.1.tar.gz
    curl -L -O https://bintray.com/artifact/download/casacore/homebrew-bottles/casacore-2.1.0.el_capitan.bottle.tar.gz
    brew install ./boost-python-1.60.0.el_capitan.bottle.1.tar.gz
    brew install ./casacore-2.1.0.el_capitan.bottle.tar.gz --with-python3

fi
