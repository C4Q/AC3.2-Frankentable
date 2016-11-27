//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

public enum SortingMethod {
    case frequency
    case alphabetical
    case none
}

class FrankenTableViewController: UITableViewController {
    
    var uniqueWordsDict = [String:Int]()
    var uniqueWordsArray = [String]()
    var sortedWordsArray = [String]()
    var sectionTitlesForFrequency = [Int]()
    var sectionTitlesForAlphabeticalOrder = [Character]()
    var sortedBy = SortingMethod.none
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "Data", withExtension: "txt"),
            let data = try? Data(contentsOf: url),
            let text = String(data: data, encoding: .utf8) {
            
            for aWord in text.components(separatedBy: [" ", ",", ".",";", "\n", "?","-","(",")"]) {
                let lowerCasedWord = aWord.lowercased()
                if lowerCasedWord != "" {
                    
                    if uniqueWordsDict[lowerCasedWord] != nil {
                        uniqueWordsDict[lowerCasedWord]! += 1
                    }
                    else {
                        uniqueWordsDict[lowerCasedWord] = 1
                        uniqueWordsArray.append(lowerCasedWord)
                    }
                }
            }
        }
    }
    
    
    @IBAction func sortByAlphabeticalOrderTapped(_ sender: UIBarButtonItem) {
        
        sectionTitlesForAlphabeticalOrder.append(contentsOf: "abcdefghijklmnopqrstuvwxyz".characters)
        sortedBy = .alphabetical
        sortedWordsArray = uniqueWordsArray.sorted()
        tableView.reloadData()
        
    }
    
    @IBAction func sortByFrequencyTapped(_ sender: UIBarButtonItem) {
        
        let sortedDict = uniqueWordsDict.sorted { (a,b) -> Bool in
            a.value > b.value
        }
        
        var myArray = [String]()
        var sectionTitles = Set<Int>()
        
        for (key,value) in sortedDict {
            myArray.append(key)
            sectionTitles.insert(value)
        }
        
        sectionTitlesForFrequency = Array(sectionTitles).sorted(by: { $0 > $1 })
        sortedWordsArray = myArray
        sortedBy = .frequency
        tableView.reloadData()
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        switch sortedBy {
            
        case SortingMethod.frequency:
            return sectionTitlesForFrequency.count
            
        case SortingMethod.alphabetical:
            return sectionTitlesForAlphabeticalOrder.count
            
        case SortingMethod.none:
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch sortedBy {
            
        case .frequency:
            
            var theArray = [String]()
            let theSection = Array(self.sectionTitlesForFrequency)[section]
            
            for (key,value) in uniqueWordsDict {
                if  value == Int(theSection) {
                    theArray.append(key)
                    
                }
            }
            return theArray.count
            
        case .alphabetical:
            
            var theArray = [String]()
            let theSection = self.sectionTitlesForAlphabeticalOrder[section]
            
            for (key,_) in uniqueWordsDict {
                let array = Array(key.characters)
                if array[0] == theSection {
                    theArray.append(key)
                }
            }
            return theArray.count
            
        case .none:
            
            return uniqueWordsArray.count
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "uniqueWordCellIdentifier", for: indexPath)
        
        var word = String()
        var frequency = Int()
        
        switch sortedBy {
            
        case .frequency:
            
            var theArray = [(key:String,value:Int)]()
            let theSection = self.sectionTitlesForFrequency[indexPath.section]
            
            for (key,value) in uniqueWordsDict {
                if value == Int(theSection) {
                    
                    theArray.append(key: key, value: value)
                }
            }
            
            let detail = theArray[indexPath.row]
            word = detail.key
            frequency = detail.value
         
        case .alphabetical:
            
            var theArray = [(key:String,value:Int)]()
            let theSection = self.sectionTitlesForAlphabeticalOrder[indexPath.section]
            
            for (key,value) in uniqueWordsDict {
                let array = Array(key.characters)
                if array[0] == theSection {
                    
                    theArray.append(key: key, value: value)
                }
            }
            
            let detail = theArray[indexPath.row]
            word = detail.key
            frequency = detail.value
            
        case .none:
            
            let theWord = uniqueWordsArray[indexPath.row]
            word = theWord
            frequency = uniqueWordsDict[theWord]!
            
        }
        
        cell.textLabel?.text = ("\(word) (\(frequency))")
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch sortedBy {
            
        case .frequency:
            return String(sectionTitlesForFrequency[section])
            
        case .alphabetical:
            return String(sectionTitlesForAlphabeticalOrder[section])
            
        case .none:
            return " "
        }
    }
    
}
