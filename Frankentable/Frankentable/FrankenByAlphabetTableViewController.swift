//
//  FrankenByAlphabetTableViewController.swift
//  Frankentable
//
//  Created by Ana Ma on 11/27/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenByAlphabetTableViewController: UITableViewController {
    
    var text: String = ""
    var stringToCountDict: [String: Int] = [:]
    var alphabetToStringArrayDict: [String:[String]] = [:]
    var sortedStringKeyArray: [String] = []
    var sortedAlphabetKeyArray: [String] = []
    let cellIdentifier = "frankenByAlphabetCellIndentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "Data", withExtension: "txt"),
            let data = try? Data(contentsOf: url),
            let text = String(data: data, encoding: .utf8) {
            
            // here's your text
            print(text)
            
            // To get string in a continuous line
            let continuousText = text.replacingOccurrences(of: "\n", with: " ")
            let continousTextWithOneSpace = continuousText.replacingOccurrences(of: "  ", with: " ")
            self.text = continousTextWithOneSpace
            
            //Get dictionary and sorted keys
            self.stringToCountDict = TextManager.manager.words(str: self.text)
            self.sortedStringKeyArray = stringToCountDict.keys.sorted{$0 < $1}
            
            self.alphabetToStringArrayDict = TextManager.manager.sortByAlphabet(arr: self.sortedStringKeyArray)
            self.sortedAlphabetKeyArray = alphabetToStringArrayDict.keys.sorted{$0 < $1}
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.alphabetToStringArrayDict.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let targetAlphabet = sortedAlphabetKeyArray[section]
        guard let array = alphabetToStringArrayDict[targetAlphabet] else { return 0}
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let targetAlphabet = sortedAlphabetKeyArray[indexPath.section]
        if let array = alphabetToStringArrayDict[targetAlphabet]{
            let word = array[indexPath.row]
            let wordCount = stringToCountDict[word]!
            cell.textLabel?.text = "\(word) (\(wordCount))"
            return cell
        }
        else { return cell }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sortedAlphabetKeyArray[section]
    }

}
