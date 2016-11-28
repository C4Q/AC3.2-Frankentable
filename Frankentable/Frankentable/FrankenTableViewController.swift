//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenTableViewController: UITableViewController {
    
    var wordCount = [String : Int]()
    var wordSorted = true
    var letterSection = [String]()
    var valueSection = [Int]()
    
    @IBAction func switchSwitched(_ sender: UISwitch) {
        wordSorted = !wordSorted
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.main.url(forResource: "Data", withExtension: "txt"),
            let data = try? Data(contentsOf: url),
            let text = String(data: data, encoding: .utf8) {
            
            // here's your text
//            print(text)
            wordCount = mostCommonWords(string: text)
            print(wordCount)
            letterSection = firstLetters(dict: wordCount)
            valueSection = countValues(dict: wordCount)
        }
        
    }

    func mostCommonWords (string: String) -> [String : Int] {
        var wordDict = [String: Int]()
        let wordArr = string.lowercased().components(separatedBy: CharacterSet.punctuationCharacters.union(CharacterSet.whitespaces).union(CharacterSet.newlines)).filter { !$0.isEmpty }
        
        for word in wordArr {
            wordDict[word] = (wordDict[word] ?? 0) + 1
        }
        
        return wordDict
    }

    func firstLetters(dict: [String : Int]) -> [String] {
        var tempDict = [String : String]()
        
        for entry in dict {
            tempDict[String(entry.key.characters.prefix(1))] = "Sup"
        }
        
        return Array(tempDict.keys).sorted()
    }
    
    func countValues(dict: [String : Int]) -> [Int] {
        var tempDict = [Int : Int]()
        
        for entry in dict {
            tempDict[entry.value] = 1
        }
        
        return Array(tempDict.keys).sorted {$0 > $1}
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if wordSorted {
            return letterSection.count
        }
        else {
            return valueSection.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if wordSorted {
            return letterSection[section]
        }
        else {
            return String(valueSection[section])
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if wordSorted {
            return wordCount.filter { String($0.key.characters.prefix(1)) == letterSection[section]}.count
        }
        else {
            return wordCount.filter {$0.value == valueSection[section]}.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCellReuse", for: indexPath)
//        var word = [String : Int]()
        if wordSorted {
            let word = wordCount.filter { String($0.key.characters.prefix(1)) == letterSection[indexPath.section]}.sorted {$0.key < $1.key}[indexPath.row]
            cell.textLabel?.text = "\(word.key) (\(word.value))"
            return cell
        }
        else {
            let word = wordCount.filter {$0.value == valueSection[indexPath.section]}.sorted {$0.value > $1.value}[indexPath.row]
            cell.textLabel?.text = "\(word.key) (\(word.value))"
            return cell
        }

        
    }

}
