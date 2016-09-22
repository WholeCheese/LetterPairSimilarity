//
//  LetterPairSimilarity.swift
//  LetterPairSimilarity
//
//  Created by Allan Hoeltje on 9/2/16.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy of
//	this software and associated documentation files (the "Software"), to deal in
//	the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//	the Software, and to permit persons to whom the Software is furnished to do so,
//	subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//	FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation

///	LetterPairSimilarity
///	From an article by Simon White.
///	See: http://www.catalysoft.com/articles/StrikeAMatch.html
open class LetterPairSimilarity: NSObject
{
	///	Compare two strings.
	///	Note that CJK strings are not handled very well since they tend to get word-parsed into single
	///	unicode characters.  This algorithm expects character pairs.
	///	- Parameters:
	///		- str1: a string to compare to str2
	///		- str2: a string to compare to str1
	///	- Returns: a lexical similarity value in the range 0...1 where 0 is no similaraity at all and 1 is a perfect match.
	open func compareStrings(_ str1: String, str2: String) -> Double
	{
		var intersection = 0

		let pairs1 = wordLetterPairs(str1)
		var pairs2 = wordLetterPairs(str2)
		let union = pairs1.count + pairs2.count

		for pair1 in pairs1
		{
			var j = 0
			for pair2 in pairs2
			{
				if pair1 == pair2
				{
					//	Note that whenever a match is found, that character pair is removed from
					//	the second array list to prevent us from matching against the same character
					//	pair multiple times. (Otherwise, 'GGGGG' would score a perfect match against 'GG'.)

					intersection += 1
					pairs2.remove(at: j)
					break	//	leave the pair2 loop
				}

				j += 1
			}
		}

		return round(100.0 * ((2.0 * Double(intersection)) / Double(union)))
	}

	///	wordLetterPairs
	/// - Parameters:
	///		- str: a string of words
	///	- Returns: an array of letter pairs from all the words in str.
	fileprivate func wordLetterPairs(_ str: String) -> [String]
	{
		var allPairs = [String]()

//		let words = str.normalizedWords()	//	TESTING - does not seem to offer any advantages, but was fun to write.
		let words = str.words()
		for word in words
		{
			let pairsInWord = letterPairs( word )
			for pair in pairsInWord
			{
				allPairs.append(pair)
			}
		}

//		print("str: \(str) \nwords: \(words) \npairs: \(allPairs)")

		return allPairs
	}


	///	Return an array of adjacent letter pairs contained in the input string
	/// - Parameters:
	///		- str: the string from which we extract letter pairs
	///	- Returns: An array of letter pair strings
	fileprivate func letterPairs(_ str: String) -> [String]
	{
		var pairs = [String]()

		let numPairs = str.characters.count - 1

//		if numPairs < 1
//		{
//			//	TODO: what do we do with one character words?
//			//	How about returning a 1 element array of the single character?
//			print("\(str)")
//		}

		for i in 0 ..< numPairs
		{
			pairs.append(str[i ..< (i + 2)])
		}

		return pairs
	}
}

extension String
{
	subscript (range: Range<Int>) -> String
	{
		//	IMHO, string subscripting ought to easier than this?  Like, maybe built into the language??
		get
		{
			//	If the range is outside of the string then just return an empty string.
			var lower = range.lowerBound
			if lower > self.characters.count
			{
				lower = self.characters.count
			}

			var upper = range.upperBound
			if upper > self.characters.count
			{
				upper = self.characters.count
			}

			let begIdx = self.characters.index(self.startIndex, offsetBy: lower)
			let endIdx = self.characters.index(begIdx, offsetBy: (upper - lower))

			return self[Range(begIdx ..< endIdx)]
		}
	}
}

extension String
{
	///	String extension to enumerate the words in the string
	///	We use a linguistic tagger to map English words like "shouldn't" to ["should", "not"] and "done" to ["do"]
	///	TODO: however it is buggy!  "should't" becomes "should not" but "can't" becomes "ca not"
	///	- Returns: An array of word strings
	func normalizedWords() -> [String]
	{
		let options = NSLinguisticTagger.Options.omitWhitespace.rawValue
			| NSLinguisticTagger.Options.omitPunctuation.rawValue
			| NSLinguisticTagger.Options.omitOther.rawValue

		let schemes	= [NSLinguisticTagSchemeLexicalClass, NSLinguisticTagSchemeLemma]
		let tagger	= NSLinguisticTagger(tagSchemes: schemes, options: Int(options))

		tagger.string = self

		let range = NSRange(location: 0, length: self.characters.count)
		var words = [String]()

		tagger.enumerateTags(
			in: range,
			scheme: NSLinguisticTagSchemeLemma,	//	supplies a stem form for each word token (if known).
			options: NSLinguisticTagger.Options(rawValue: options))
		{
			(tag, tokenRange, _, _) -> () in
			let token = (self as NSString).substring(with: tokenRange)
//			print("\(tag): \(token)")

			words.append( (tag.isEmpty) ? token.lowercased() : tag.lowercased())
		}

		return words
	}
}

extension String
{
	///	Cool extension taken from Three Ways to Enumerate the Words In a String Using Swift.
	///	https://medium.com/@sorenlind/three-ways-to-enumerate-the-words-in-a-string-using-swift-7da5504f0062#.mi9oick6x
	///	- Returns: An array of word strings
	func words() -> [String]
	{
		//	The NSStringEnumerationOptions ByWords correctly handles unicode characters.
		//	TODO: but does it correctly handle CJK words?
		let range = Range<String.Index>(self.characters.startIndex ..< self.characters.endIndex)
		var words = [String]()

		self.enumerateSubstrings(in: range, options: NSString.EnumerationOptions.byWords)
		{
			(substring, _, _, _) -> () in
				words.append(substring!.lowercased())
		}

		return words
	}
}
