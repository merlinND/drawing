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
 * Filters
 */
/** Reject words shorter than `length` */
var minLength = function(length) {
  return function(w) {
    return (w.length >= length);
  };
};
/** Reject words not equal to `reference` */
var byValue = function(reference) {
  return function(w) {
    return w === reference;
  };
};
/** Whether `list` contains `value` */
var contains = function(list, value) {
  for (var i = 0; i < list.length; i += 1) {
    if(list[i] === value) {
      return true;
    }
  }
  return false;
};

/**
 * Sorts
 */
var byLength = function(a, b) {
  return a.length - b.length;
};

/**
 * Mapping functions
 */
var trimmer = function(w) {
  return w.trim();
};
/** Place a space between each char */
var spacer = function(s) {
  return s.replace(/([^ ])/gi, '$1 ').trim();
};
/** Sort the given list */
var sorter = function(l) {
  return l.sort();
};

/** Associate each distinct value with its occurrence count. Put the results in the object `container` */
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
/** Associate each distinct length with a list of words having this length. Put the results in the object `container` */
var groupByLength = function(container) {
  return function(w) {
    if(!container[w.length]) {
      container[w.length] = [w];
    }
    else {
      container[w.length].push(w);
    }
  };
};
/** Associate each distinct `counts` value with a list of words with this number of occurrences. Put the results in the object `container` */
var groupByCount = function(counts, container) {
  return function(w) {
    if(!container[counts[w]]) {
      container[counts[w]] = [w];
    }
    else if(!contains(container[counts[w]], w)){
      container[counts[w]].push(w);
    }
  };
};

/**
 * Transforms
 */
/** Turn text into a clean list of words */
var getWords = function(text, minimumLength) {
  if(!minimumLength) {
    minimumLength = 1;
  }

  text = ('' + text)
    .toLowerCase()
    .replace(strips, '')
    .replace(seqs, '')
    .replace(spaced, ' ')
    .trim();

  return text
    .split(' ')
    .map(trimmer)
    .filter(minLength(minimumLength));
};
/** Gives a "grid of chars" effect */
var getSpacedWords = function(words) {
  words = Object.keys(getWordsCount(words));
  return words
    .sort(byLength)
    .map(spacer)
    .join(' ');
};
/** For each word, get the number of occurrences */
var getWordsCount = function(words) {
  var occurrences = {};
  words.map(groupByValue(occurrences));
  return occurrences;
};
/** For each count, get the ordered list of words with that count */
var getWordsByCount = function(words) {
  var occurrences = {};
  words.map(groupByCount(getWordsCount(words), occurrences));
  Object.keys(occurrences).forEach(function(k) {
    occurrences[k] = occurrences[k].sort();
  });
  return occurrences;
};

fs.readFile('./data/article.md', function(err, text) {
  var words = getWords(text);

  // console.log(words);
  console.log(getSpacedWords(words));
  //console.log(getWordsCount(words));
  // console.log(getWordsByCount(words));
});
