//
//  ViewController.swift
//  Silly Song
//
//  Created by Baker, Travis on 1/16/17.
//  Copyright © 2017 Baker, Travis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let vowels: [Character] = ["a", "e", "i", "o", "u"]
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        if nameField.text == "" {
            return
        }
        
        let lyrics = lyricsForName(lyricsTemplate: bananaFanaTemplate, firstName: nameField.text!)
        
        lyricsView.text = lyrics
    }
    
    // MARK: Utility functions
    // Returns a short name that is lowercase with any leading consonants removed
    func shortNameFromName(name: String) -> String {
        var name = name.lowercased()
        // Remove any accents from the string
        var localizedName = String(data: name.data(using: .ascii, allowLossyConversion: true)!, encoding: .ascii)!
        var firstChar = localizedName[localizedName.startIndex]
        // Remove consonants from beginning of string
        while !vowels.contains(firstChar) {
            name.remove(at: name.startIndex)
            localizedName.remove(at: localizedName.startIndex)
            firstChar = localizedName[localizedName.startIndex]
        }
        return name
    }
    
    func lyricsForName(lyricsTemplate: String, firstName: String) -> String {
        return lyricsTemplate
            .replacingOccurrences(of: "<FULL_NAME>", with: firstName)
            .replacingOccurrences(of: "<SHORT_NAME>", with: shortNameFromName(name: firstName))
    }

}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

