#!/bin/sh
cd "${0%/*}"/.. # CD to parent of directory where this script is located
curl -L https://github.com/mozilla/geckodriver/releases/download/v0.16.0/geckodriver-v0.16.0-linux64.tar.gz | tar xz
mv geckodriver bin/