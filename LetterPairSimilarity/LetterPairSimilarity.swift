//
//  LetterPairSimilarity.swift
//  LetterPairSimilarity
//
//  Created by Allan Hoeltje on 9/2/16.
//  Copyright © 2016 Allan Hoeltje. All rights reserved.
//

import Foundation

///	LetterPairSimilarity
///	From an article by Simon White.
///	See: http://www.catalysoft.com/articles/StrikeAMatch.html
public class LetterPairSimilarity: NSObject
{
	///	Compare two strings.
	///	- Parameters:
	///		- str1: a string to compare to str2
	///		- str2: a string to compare to str1
	///	- Returns: a lexical similarity value in the range 0...1 where 0 is no similaraity at all and 1 is a perfect match.
	public func compareStrings(str1: String, str2: String) -> Double
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
					pairs2.removeAtIndex(j)
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
	private func wordLetterPairs(str: String) -> [String]
	{
		var allPairs = [String]()

//		let words = str.normalizedWords()
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
	private func letterPairs(str: String) -> [String]
	{
		var pairs = [String]()

		let numPairs = str.characters.count - 1

//		if numPairs < 1
//		{
//			//	TODO: what do we do with one character words?
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
		get
		{
			let startIndex = self.startIndex.advancedBy(range.startIndex)
			let endIndex = startIndex.advancedBy(range.endIndex - range.startIndex)

			return self[Range(startIndex ..< endIndex)]
		}
	}
}

extension String
{
	///	String extension to enumerate the words in the string
	///	We use a linguistic tagger to map English words like "shouldn't" to ["should", "not"] and "done" to ["do"]
	///	- Returns: An array of word strings
	func normalizedWords() -> [String]
	{
		let options = NSLinguisticTaggerOptions.OmitWhitespace.rawValue
			| NSLinguisticTaggerOptions.OmitPunctuation.rawValue
			| NSLinguisticTaggerOptions.OmitOther.rawValue

		let schemes	= [NSLinguisticTagSchemeLexicalClass, NSLinguisticTagSchemeLemma]
		let tagger	= NSLinguisticTagger(tagSchemes: schemes, options: Int(options))

		tagger.string = self

		let range = NSRange(location: 0, length: self.characters.count)
		var words = [String]()

		tagger.enumerateTagsInRange(
			range,
			scheme: NSLinguisticTagSchemeLemma,	//	supplies a stem form for each word token (if known).
			options: NSLinguisticTaggerOptions(rawValue: options))
		{
			(tag, tokenRange, _, _) -> () in
			let token = (self as NSString).substringWithRange(tokenRange)
//			print("\(tag): \(token)")

			words.append( (tag.isEmpty) ? token.lowercaseString : tag.lowercaseString)
		}

		return words
	}
}

extension String
{
	///	Cool extension taken from Three Ways to Enumerate the Words In a String Using Swift
	///	https://medium.com/@sorenlind/three-ways-to-enumerate-the-words-in-a-string-using-swift-7da5504f0062#.mi9oick6x
	///	- Returns: An array of word strings
	func words() -> [String]
	{
		let range = Range<String.Index>(self.startIndex ..< self.endIndex)
		var words = [String]()

		self.enumerateSubstringsInRange(range, options: NSStringEnumerationOptions.ByWords)
		{
			(substring, _, _, _) -> () in
				words.append(substring!.lowercaseString)
		}

		return words
	}
}
