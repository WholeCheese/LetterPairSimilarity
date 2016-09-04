//
//  LetterPairSimilarityTests.swift
//  LetterPairSimilarityTests
//
//  Created by Allan Hoeltje on 9/2/16.
//  Copyright © 2016 Allan Hoeltje. All rights reserved.
//

import XCTest
@testable import LetterPairSimilarity

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
		TestCase(str1: "あなたはそれを行うべきではありません。", str2: "あなたはそれを行うべきではありません。", score: 100.0)
		]

	let test2Cases = [
		TestCase(str1: "Web Database Applications", str2: "Web Database Applications with PHP & MySQL", score: 82.0),
		TestCase(str1: "Web Database Applications", str2: "Creating Database Web Applications with PHP and ASP", score: 71.0),
		TestCase(str1: "Web Database Applications", str2: "Building Database Applications on the Web Using PHP3", score: 70.0),
		TestCase(str1: "Web Database Applications", str2: "Building Web Database Applications with Visual Studio 6", score: 67.0),
		TestCase(str1: "Web Database Applications", str2: "Web Application Development With PHP", score: 51.0),
		TestCase(str1: "Web Database Applications", str2: "WebRAD: Building Database Applications on the Web with Visual FoxPro and Web Connection", score: 49.0),
		TestCase(str1: "Web Database Applications", str2: "Structural Assessment: The Role of Large and Full-Scale Testing", score: 12.0),
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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

		let lps = LetterPairSimilarity()

		for testCase in test1Cases
		{
			let score = lps.compareStrings( testCase.str1, str2: testCase.str2)
			print( "\(testCase.str1) ~ \(testCase.str2) Score: \(score) expected: \(testCase.score)" )
		}
    }

	func test2()
	{
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.

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
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.

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
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.

		let lps = LetterPairSimilarity()
		var i = 1
		for testCase in test4Cases
		{
			let score = lps.compareStrings( testCase.str1, str2: testCase.str2)
			print( "\(i) Score: \(score) expected: \(testCase.score)" )
			i += 1
		}
	}
}
