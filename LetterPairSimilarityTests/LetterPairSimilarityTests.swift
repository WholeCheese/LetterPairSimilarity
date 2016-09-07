//
//  LetterPairSimilarityTests.swift
//  LetterPairSimilarityTests
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

import XCTest
@testable import LetterPairSimilarity

///	Test cases 1 through 4 were taken from the article "How to Strike a Match" by Simon White.
///	See: http://www.catalysoft.com/articles/StrikeAMatch.html

class LetterPairSimilarityTests: XCTestCase
{
	struct TestCase
	{
		var str1:	String
		var str2:	String
		var score:	Double
	}

	let test1Cases = [
		TestCase(str1: "France", str2: "French", score: 40.0),
		TestCase(str1: "France", str2: "Republic of France", score: 56.0),
		TestCase(str1: "France", str2: "Quebec", score: 0.0),
		TestCase(str1: "French Republic", str2: "Republic of France", score: 72.0),
		TestCase(str1: "French Republic", str2: "Republic of Cuba", score: 61.0),
		TestCase(str1: "Healed", str2: "Sealed", score: 80.0),
		TestCase(str1: "Healed", str2: "Healthy", score: 55.0),
		TestCase(str1: "Healed", str2: "Heard", score: 44.0),
		TestCase(str1: "Healed", str2: "Herded", score: 40.0),
		TestCase(str1: "Healed", str2: "Help", score: 25.0),
		TestCase(str1: "Healed", str2: "Sold", score: 0.0),
		]

	let test2Cases = [
		TestCase(str1: "Web Database Applications", str2: "Web Database Applications with PHP & MySQL", score: 82.0),
		TestCase(str1: "Web Database Applications", str2: "Creating Database Web Applications with PHP and ASP", score: 71.0),
		TestCase(str1: "Web Database Applications", str2: "Building Database Applications on the Web Using PHP3", score: 70.0),
		TestCase(str1: "Web Database Applications", str2: "Building Web Database Applications with Visual Studio 6", score: 67.0),
		TestCase(str1: "Web Database Applications", str2: "Web Application Development With PHP", score: 51.0),
		TestCase(str1: "Web Database Applications", str2: "WebRAD: Building Database Applications on the Web with Visual FoxPro and Web Connection", score: 49.0),
		TestCase(str1: "Web Database Applications", str2: "Structural Assessment: The Role of Large and Full-Scale Testing", score: 13.0),
		TestCase(str1: "Web Database Applications", str2: "How to Find a Scholarship Online", score: 10.0),
		]


	let test3Cases = [
		TestCase(str1: "PHP Web Applications", str2: "Web Database Applications with PHP & MySQL", score: 68.0),
		TestCase(str1: "PHP Web Applications", str2: "Creating Database Web Applications with PHP and ASP", score: 59.0),
		TestCase(str1: "PHP Web Applications", str2: "Building Database Applications on the Web Using PHP3", score: 58.0),
		TestCase(str1: "PHP Web Applications", str2: "Building Web Database Applications with Visual Studio 6", score: 47.0),
		TestCase(str1: "PHP Web Applications", str2: "Web Application Development With PHP", score: 67.0),
		TestCase(str1: "PHP Web Applications", str2: "WebRAD: Building Database Applications on the Web with Visual FoxPro and Web Connection", score: 34.0),
		TestCase(str1: "PHP Web Applications", str2: "Structural Assessment: The Role of Large and Full-Scale Testing", score: 7.0),
		TestCase(str1: "PHP Web Applications", str2: "How to Find a Scholarship Online", score: 11.0),
		]


	let test4Cases = [
		TestCase(str1: "Web Aplications", str2: "Web Database Applications with PHP & MySQL", score: 59.0),
		TestCase(str1: "Web Aplications", str2: "Creating Database Web Applications with PHP and ASP", score: 50.0),
		TestCase(str1: "Web Aplications", str2: "Building Database Applications on the Web Using PHP3", score: 49.0),
		TestCase(str1: "Web Aplications", str2: "Building Web Database Applications with Visual Studio 6", score: 46.0),
		TestCase(str1: "Web Aplications", str2: "Web Application Development With PHP", score: 56.0),
		TestCase(str1: "Web Aplications", str2: "WebRAD: Building Database Applications on the Web with Visual FoxPro and Web Connection", score: 32.0),
		TestCase(str1: "Web Aplications", str2: "Structural Assessment: The Role of Large and Full-Scale Testing", score: 7.0),
		TestCase(str1: "Web Aplications", str2: "How to Find a Scholarship Online", score: 12.0),
		]

	let test5Cases = [
		//	Thanks to Google Translate for the CJK strings.
		//	English
		TestCase(str1: "You should not do it.", str2: "You can not do it.", score: 63.0),

		//Chinese Traditional
		TestCase(str1: "你不應該這樣做。", str2: "你可能不這樣做。", score: 50.0),

		//	Chinese Simplified
		TestCase(str1: "你不应该这样做。", str2: "你可能不这样做。", score: 50.0),

		//	Japanese
		TestCase(str1: "あなたはそれを行うべきではありません。", str2: "あなたはそれをしない可能性があります。", score: 57.0),

		//	Korean
		TestCase(str1: "당신 은 그렇게 해서는 없습니다.", str2: "당신 은 그것을 하지 않을 수 있습니다.", score: 38.0),
		]

   override func setUp()
	{
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown()
	{
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test1()
	{
		let lps = LetterPairSimilarity()

		for testCase in test1Cases
		{
			let score = lps.compareStrings( testCase.str1, str2: testCase.str2)
			print( "\(testCase.str1) ~ \(testCase.str2) Score: \(score) expected: \(testCase.score)" )
		}
    }

	func test2()
	{
		let lps = LetterPairSimilarity()
		var i = 1
		for testCase in test2Cases
		{
			let score = lps.compareStrings( testCase.str1, str2: testCase.str2)
			print( "\(i) Score: \(score) expected: \(testCase.score)" )
			i += 1
		}
	}

	func test3()
	{
		let lps = LetterPairSimilarity()
		var i = 1
		for testCase in test3Cases
		{
			let score = lps.compareStrings( testCase.str1, str2: testCase.str2)
			print( "\(i) Score: \(score) expected: \(testCase.score)" )
			i += 1
		}
	}

	func test4()
	{
		let lps = LetterPairSimilarity()
		var i = 1
		for testCase in test4Cases
		{
			let score = lps.compareStrings( testCase.str1, str2: testCase.str2)
			print( "\(i) Score: \(score) expected: \(testCase.score)" )
			i += 1
		}
	}

	func test5()
	{
		let lps = LetterPairSimilarity()
		var i = 1
		for testCase in test5Cases
		{
			let score = lps.compareStrings( testCase.str1, str2: testCase.str2)
			print( "\(i) Score: \(score) expected: \(testCase.score)" )
			i += 1
		}
	}
}
