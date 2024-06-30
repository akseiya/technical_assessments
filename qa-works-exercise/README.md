# QA Works exercise

## Pre-requisites

The test is implemented with [Webdriver.io][wdio] without portability handling,
which means following prerequisites:
- Linux host machine with Node.js 6.11.2
- working Internet connection

[wdio]: http://webdriver.io
[getnode]: https://nodejs.org/en/download/

## Running

Use the provided [`run.sh`][runsh] script.

[runsh]: ./run.sh

The test is run in PhantomJS and produces results in [Allure][] and JUnit formats,
both of which can be consumed by Jenkins. JUnit is accepted by majority if not
all broadly used CD/CI tools.

[Allure]: http://webdriver.io/guide/reporters/allure.html

## The surprise

As of 2018-04-14 18:21 the submission form was not working, giving the error
message
<center>
⚠ THERE WAS AN ERROR TRYING TO SEND YOUR MESSAGE.<br/>
PLEASE TRY AGAIN LATER.
</center>

I confirmed that it's not a deliberate testing fuction reacting to enquiries
from within `qaworks.com`.

Since there was no acceptance criteria for being able to contact QA Works,
I had no known way of asserting that the test step has passed.
For the time being, I made it so that I expect a submission result box
to appear, but with a role different from `alert`.

This also means that, as of Saturday evening, the test is failing on
an actual issue with the webpage.

## Nitpicking

While the technical challenge includes acceptance criteria for itself,
the test to be implemented lacks them.

Either the spec is outdated, or the page is in error, since there is no
`subject` field, while there is a 'Company' field. Since QA Works provides
services to companies, it is technically sensible that 'Company' field be
compulsory. For this exercise, I'm dropping 'subject' and adding 'company'.
The field does not have `aria-required` flag _as implemented_, so if I had chosen
pure Selenium as platform, I might have burnt a bit of time to make the scenario an
outline where a Valid Submission does or does not include company/project name.

Scenario provided mixes an action with its expected results (it has no `When`
before <nobr>a `Then`</nobr>). I took the liberty to split them while investigating
an obscure error message from WDIO miscommunicating with Cucumber.

Data table does not follow usual Gherkin conventions*, although it can be used and
its format does make sense for a single example with multiple inputs. It can, however,
be not portable to other platform (i.e. I don't think Ruby's original Cuke would
accept it).

*) Normally I'd expect something like below instead, even for
   a single input set:
   ```
   | name     | subject         | email                | message                                   |
   | j.Bloggs | test automation | j.Bloggs@qaworks.com | please contact me I want to find out more |
   ```

Email address used as input is within `qaworks.com` domain. I assume that, when
used for an initial contact form, any email from within `qaworks.com` is
considered a test account and does not skew traffic stats.

## Highlights

### Why WDIO?

Because I have only _reviewed_ test suites in WDIO so far. My impression was that
of little flexibility* and but <nobr>a few</nobr> particularly impressive
advantages over pure Selenium. I did not, however, properly explore WDIO's
capabilities for cross-browser testing with equal(?) treatment of desktop and
mobile platforms.

*) e.g. when it comes to situations requiring extra parallelism which means
customer commands to start Cucumber.js

#### _I have made a huge mistake_

Currently WDIO doesn't seem exactly on top of changes in Cucumber.js:
- Cucumber.js installed by WDIO deprecates `defineSupportCode` and prescribes
  importing Gherkin verbs directly; however, attempting
  ```js
  const { Given, When, Then } = require('cucumber');
  ```
  has resulted, for me, with
  ```
  ERROR: Cannot read property 'split' of undefined
  phantomjs
  ```
  which I have, after some investigation, tracked to `{ Given, When, Then}`
  being an empty object after the import. Restoring the old fashion of
  importing Cucumber interface and downgrading adapter version to 1 restored
  WDIO's ability to run tests.

Due to excessive time consumed by WDIO hiccups, I have only implemented the
basic prescribed test with no real improvements or extensions.

### Why all the shellscripts, do you have too much time?

In my last position I took part in several QA candidate interviews and code
exercise reviews. I noticed that most of my colleagues were considerably
unhappy when the test suite didn't run out of the box. While I didn't want to
shoulder the cost of dockerisation right now, I also didn't want to cause
such disappointment.

## Final notes

While in initial stages of solving the challenge I followed the WDIO docs,
I discovered at some point that getting a shell and X Server in Windows 10
is not as trivial as to just do it while downloading Ubuntu image for VirtualBox
is not exactly an option on a mobile connection. Thus, while I left their
installation scripts in the directory, they are not currently used, just PhantomJS
which gets set up by `npm i` for its WDIO adapter.

I hope that the enquiry submission issue gets fixed quickly!
