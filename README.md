# LetterPairSimilarity

## Introduction and License
This is a Swift implementation of a BiGram string matching algorithm originally written by Simon White in Java called LetterSimilarity.  See: http://www.catalysoft.com/articles/StrikeAMatch.html

This implementation is placed in the Public Domain.


## Usage Example
```swift
let lps = LetterPairSimilarity()
let score = lps.compareStrings( "French Republic", str2: "Republic of France")

//  score is a Double from 0.0 to 100.0 where 0.0 is no similarity at all, 100.0 is an exact match.
...
```
Enjoy!
-Allan
