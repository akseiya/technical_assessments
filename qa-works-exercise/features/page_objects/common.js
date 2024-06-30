class Page {
    static url() { return 'about:blank'; }
    static open() { browser.url(this.url()); }
}

module.exports = { Page };