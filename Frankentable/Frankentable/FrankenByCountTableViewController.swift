//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenByCountTableViewController: UITableViewController {
    
    var text: String = ""
    var stringToCountdict: [String: Int] = [:]
    var countToArrayOfStringDict: [Int:[String]] = [:]
    var sortedStringKeyArray: [String] = []
    var sortedCountKeyArray: [Int] = []
    let cellIdentifier = "frankenByCountCellIndentifier"

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
            self.stringToCountdict = TextManager.manager.words(str: self.text)
            self.sortedStringKeyArray = stringToCountdict.keys.sorted{ stringToCountdict[$0]! > stringToCountdict[$1]! }
            
            self.countToArrayOfStringDict = TextManager.manager.sortByCount(dict: self.stringToCountdict)
            self.sortedCountKeyArray = countToArrayOfStringDict.keys.sorted { $0 > $1 }
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sortedCountKeyArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let targetCount = sortedCountKeyArray[section]
        guard let array = countToArrayOfStringDict[targetCount] else { return 0}
        return array.count
        //return sortedArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let targetCount = sortedCountKeyArray[indexPath.section]
        if let array = countToArrayOfStringDict[targetCount]{
            let word = array[indexPath.row]
            let wordCount = stringToCountdict[word]!
            cell.textLabel?.text = "\(word) (\(wordCount))"
            return cell
        }
        else { return cell }
//        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
//        let word = sortedArray[indexPath.row]
//        let wordCount = stringToCountdict[word]!
//        cell.textLabel?.text = "\(word) (\(wordCount))"
//        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(self.sortedCountKeyArray[section])
    }

}
