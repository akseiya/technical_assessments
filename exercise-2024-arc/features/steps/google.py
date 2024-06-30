import sys
from behave import *
from selenium import webdriver

# from selenium.webdriver.chrome.options import Options

from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

# Chromium 121

@given(u'I open Google Search')
def open_google(context):
  chromeOptions = webdriver.ChromeOptions()
  # opts = Options()
  chromeOptions.binary_location = '/usr/bin/chromium-browser'
  chromeOptions.add_argument("--disable-setuid-sandbox")
  chromeOptions.add_argument("--no-sandbox")
  chromeOptions.add_argument("--disable-dev-shm-using")
  wd = webdriver.Chrome(options=chromeOptions)
  wd.get('http://google.com')
  print("\n\n\nNavigation sent\n\n\n", file=sys.stderr)
  assert 'Google Search' in wd.title

