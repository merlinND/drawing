'use strict';

var fs = require('fs');

/**
 * Parameters
 */
/** Chars to be stripped out */
var strips = /[“”‘\?!#\.:,;()"''\d]*/gi;
/** Chars to be replaced by a single space */
var spaced = /[\n-/]+/gi;
/** Sequences to be stripped */
var seqs = /’s/gi;

/**
 * Functions to be applied to each word
 */
var trimmer = function(w) {
  return w.trim();
};
var minLength = function(length) {
  return function(w) {
    return (w.length >= length);
  };
};
var byLength = function(a, b) {
  return a.length - b.length;
};
var groupByValue = function(container) {
  return function(w) {
    if(!container[w]) {
      container[w] = 1;
    }
    else {
      container[w] = container[w] + 1;
    }
  };
};
// Place a space between each char
var spacer = function(s) {
  return s.replace(/([^ ])/gi, '$1 ').trim();
};

fs.readFile('./data/article.md', function(err, text) {
  text = ('' + text)
    .toLowerCase()
    .replace(strips, '')
    .replace(seqs, '')
    .replace(spaced, ' ')
    .trim();

  var words = text
    .split(' ')
    .map(trimmer)
    .filter(minLength(1));
  // console.log(words);

  var occurrences = {};
  words.map(groupByValue(occurrences));
  // console.log(occurrences);

  // Take unique words
  var unique = Object.keys(occurrences)
    .sort(byLength);
  //console.log(unique.join(' '));


  var string = unique
    .map(spacer)
    .join(' ');
  console.log(string);
});
