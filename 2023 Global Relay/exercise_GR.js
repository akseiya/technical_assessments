/*  Finds the longest word in a `sentence` and invokes the `callback`
    with that longest word as parameter.
    @param {string} sentece The sentence
*/
function call_me_for_the_longest_word(sentence, callback) {
    const words = sentence.split(/\W/);
    let max_length = 0, index;
    words.forEach((word, wi) => {
        if(word.length > max_length) {
            max_length = word.length;
            index = wi;
        }
    });
    callback(JSON.stringify(words));
    callback(words[index]);
}

call_me_for_the_longest_word("Uncle Joe had a farmąść.", console.log);