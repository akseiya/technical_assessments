const { Page } = require('./common');
const wdio = browser;

const pry = require('pryjs')

class HomePage extends Page {
    static url() { return '/' } // baseUrl is in wdio config file

    static contactFormInput(which) {
        const inputsSelectors = {
            name:    'form input[name="your-name"]',
            company: 'form input[name="your-company"]',
            email:   'form input[name="your-email"]',
            message: 'form textarea[name="your-message"]',
        };
        if (!inputsSelectors[which])
            throw new Error(`Uknown contact form input: ${which}`);
        const input = wdio.element(inputsSelectors[which]);
        return input;
    }

    static sendEnquiry() {
        wdio.click('#qaworks-enquiry');
    }

    static submissionResult() {
        const resultSelector = 'form .wpcf7-response-output';
        wdio.waitForVisible(resultSelector, LongLoadWaitTime);
        const resultElement = wdio.element(resultSelector);
        resultElement.success = (resultElement.getAttribute('role') != 'alert');
        return resultElement;
    }
}

module.exports = { HomePage };
