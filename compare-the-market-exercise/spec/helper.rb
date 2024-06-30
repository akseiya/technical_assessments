require 'pry'
require 'capybara'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative '../lib/pages.rb'
require_relative '../lib/browser_window_box.rb'

# :selenium is the default Firefox webdriver
SupportedDrivers = [:chrome, :selenium]
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

def initialize_browser
  webdriver = ENV['WEBDRIVER'] || :chrome
  unless SupportedDrivers.include? webdriver
    raise "Unsupported webdriver '#{webdriver}'"
  end
  Capybara.current_driver = webdriver
  browser = Capybara.current_session.driver.browser.manage
  unless browser
    raise "Your driver doesn't support browser.manage"
  end
  BrowserWindowBox.apply_size browser
  browser.delete_all_cookies
end


