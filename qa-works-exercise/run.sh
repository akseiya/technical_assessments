#!/bin/sh
cd "${0%/*}" # CD to directory where this script is located

# Selenium and Geckodriver won't work within Cloud9 anyway.

# [ -f bin/selenium.jar ] || ./bin/get_selenium.sh
# [ -f bin/geckodriver ]  || ./bin/get_geckodriver.sh

npm i && npm t
