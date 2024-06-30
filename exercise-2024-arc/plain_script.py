#!/usr/bin/env -S pipenv run python

import sys
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

chrome_options = webdriver.ChromeOptions()
chrome_options.binary_location = '/usr/bin/chromium-browser'
chrome_options.add_argument("--remote-debugging-port=9222")
# chromeOptions.add_argument("--no-sandbox")
# chromeOptions.add_argument("--disable-shm-usage")

wd = webdriver.Chrome(options=chrome_options)

wd.get('http://google.com')
assert 'Google' in wd.title

reject = wd.find_element(By.XPATH, '//button[normalize-space()="Reject all"]')
reject.click()
searchbox = wd.find_element(By.XPATH, '//textarea[@name="q"]')
searchbox.send_keys('Doge\n')
assert 'Doge - Google Search' in wd.title

# import pry; pry()

wd.close()


