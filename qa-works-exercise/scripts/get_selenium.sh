#!/bin/sh
cd "${0%/*}"/.. # CD to parent of directory where this script is located
SELENIUM="selenium-server-standalone-3.5.3.jar"
curl -O http://selenium-release.storage.googleapis.com/3.5/"$SELENIUM"
mv "$SELENIUM" bin/
cd bin
ln -s `pwd`/"$SELENIUM" ./selenium.jar
