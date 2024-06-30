# Compare the Market exercise
Framework and scenarios for CtM's technical challenge

## Solution

To achieve the requested goal of running a set of tests on a remote webpage I decided to use
- RSpec for base testing capabilities with specification-by-example approach
- Selenium + Chromedriver as the base automation tool (headless drivers introduce risk of inability to render certain dynamic pages)
- Capybara as the BDD layer

Capybara provides its own layer of abstraction and human readability, thus the PageObjects-like code is generally limited to masking
raw selectors for automation-unfriendly elements. Page elements are still Capybara/Selenium objects with their usual query/interaction capabilities.

## Infrastructure

The scripts and framework have been written for running under Ubuntu 16.04 LTS.

Remote Git repository considerations are outside scope. Whichever way the code has landed on its target machine, I'm only concerned with steps that might need to be taken once it's there.

### Prerequisites

1. bash
1. Ruby 2.3
1. Bundler
1. Google Chrome

## Running the tests

The `spec` script provided in root directory of the repo is intended to run the test suite in virtual framebuffer, producing results as text output in the terminal.
By default, virtual screen size is 1920x1080 and can be overriden with `SCREEN_SIZE` environment variable. Bear in mind that this mostly affects possible screenshots, since the browser window size is a separate concern.
At least via Capybara, the [multiple instance problem] of Chromedriver seems to be still occuring, so parallelization requires containers. I haven't recently checked for any similar problems with Firefox.

[multiple instance problem]: http://stackoverflow.com/questions/12334798/run-multiple-chromedriver-sessions 

## Test scope

Chief branches of the user journey seem to be:
- quote with or without bill to hand (enables entering particular tariff etc)
- quote for gas, energy or both (extra data entries available)

### Limitations

The challenge description refers to best coverage of functionality, thus I limit the tests to functional ones, while not completely abandoning the capabilities for non-functional tests. Browser/OS support, performance, responsive design etc are considered non-functional. The code allows using different Capybara drivers and window sizes.

The extra feature of back navigation, while useful, does not seem crucial.

Testing the mail quote would require extra setup (receiving account) and code (retrieving the message). Descoped.

### Scenarios

1. Getting joint gas and electricity quote using a bill and single provider
1. Getting joint quote with a bill for a mix of providers
1. Getting a joint quote without a bill (this disables single provider option - why? - so two different ones are tested)
