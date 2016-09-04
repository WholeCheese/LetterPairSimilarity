//
//  ViewController.swift
//  LetterPairSimilarity
//
//  Created by Allan Hoeltje on 9/2/16.
//  Copyright © 2016 Allan Hoeltje. All rights reserved.
//

import Cocoa

class ViewController: NSViewController
{
	override func viewDidLoad()
	{
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override var representedObject: AnyObject?
	{
		didSet
		{
			// Update the view, if already loaded.
		}
	}

	@IBAction func wholeCheese(sender: AnyObject)
	{
		NSWorkspace.sharedWorkspace().openURL(NSURL(string: "http://WholeCheese.com")!)
	}
}
