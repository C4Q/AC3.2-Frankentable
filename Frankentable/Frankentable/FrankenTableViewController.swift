//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenTableViewController: UITableViewController {
    
    var words: [Word] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.main.url(forResource: "Data", withExtension: "txt"),
            let data = try? Data(contentsOf: url),
            let text = String(data: data, encoding: .utf8) {
            
            // here's your text
            print(text)
            self.words = self.wordsWithCount(str: text)
        }
    }
    
    func wordsWithCount(str: String) -> [Word] {
        var wordDict = [String: Int]()
        let justTheWordsArr = str.components(separatedBy: CharacterSet.punctuationCharacters.union(.whitespacesAndNewlines)).filter { !$0.isEmpty }
        
        for word in justTheWordsArr {
            let lcWord = word.lowercased()
            wordDict[lcWord] = (wordDict[lcWord] ?? 0) + 1
        }
        let sortedWordArr = wordDict.sorted { $0.value > $1.value }
        
        return sortedWordArr.map { Word.init(name: $0.key.capitalized, count: $0.value) }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 26
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(Character(UnicodeScalar(65 + section)!))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letter = String(Character(UnicodeScalar(65 + section)!))
        print(".......... \(letter)")
        let sectionPredicate = NSPredicate(format: "name BEGINSWITH '\(letter)'")
        
        return words.filter { sectionPredicate.evaluate(with: $0) }.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let letter = String(Character(UnicodeScalar(65 + indexPath.section)!))
        let sectionPredicate = NSPredicate(format: "name BEGINSWITH '\(letter)'")
        let thisWord = words.filter { sectionPredicate.evaluate(with: $0) }[indexPath.row]
        cell.textLabel?.text = "\(thisWord.name): (\(thisWord.count))"

        return cell
    }
    
}
