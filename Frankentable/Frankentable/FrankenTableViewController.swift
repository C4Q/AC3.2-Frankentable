//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenTableViewController: UITableViewController {
    //MARK: - Properties
    let identifier: String = "frankensteinCell"
    var wordsFrequencyArray: [(String, Int)] = []
    var alphabetArray: [Character] = []
    var frequencyArray: [Int] = []
    var isSwitchOn: Bool = true
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        createAlphabetArray()
        
        if let url = Bundle.main.url(forResource: "Data", withExtension: "txt"),
            let data = try? Data(contentsOf: url),
            let text = String(data: data, encoding: .utf8) {
            wordsFrequencyArray = createArrayOfWords(input: text)
            frequencyArray = createFrequencyArray()
        }
    }
    
    func createAlphabetArray() {
        for letter in "abcdefghijklmnopqrstuvwxyz".characters {
            alphabetArray.append(letter)
        }
    }
    
    func createArrayOfWords(input: String) -> [(String, Int)]{
        var dict = [String: Int]()
        
        //accounting for punctuation marks in text file
        var cSet = CharacterSet()
        cSet.insert(charactersIn: ".,?!:;&()*+-@#$%^`~_<>'0123456789\n ")
        
        let frankensteinArray: [String] = input.components(separatedBy: cSet).map { $0.lowercased() }
        for i in frankensteinArray {
            dict[i] = (dict[i] ?? 0) + 1
        }
        dict.removeValue(forKey: "")
        let x = dict.sorted(by: { $0.value > $1.value })
        return x
    }
    
    func createFrequencyArray() -> [Int]{
        var sectionTitles = Set<Int>()
        
        for i in wordsFrequencyArray {
            sectionTitles.insert(i.1)
        }
        return Array(sectionTitles).sorted(by: { $0 > $1 })
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.isSwitchOn {
            return alphabetArray.count
        } else {
            return frequencyArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.isSwitchOn {
            return String(alphabetArray[section])
        } else {
            return String(frequencyArray[section])
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSwitchOn {
            var wordsInSection = [String]()
            let sectionCharacter = self.alphabetArray[section]
            
            for (word, _) in wordsFrequencyArray {
                let array = Array(word.characters)
                if array[0] == sectionCharacter {
                    wordsInSection.append(word)
                }
            }
            return wordsInSection.count
        } else {
            
            var wordsWithGivenFrequency = [String]()
            let sectionFrequency = Array(self.frequencyArray)[section]
            
            for (word,numberOfOccurrences) in wordsFrequencyArray {
                if numberOfOccurrences == Int(sectionFrequency) {
                    wordsWithGivenFrequency.append(word)
                    
                }
            }
            return wordsWithGivenFrequency.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath)
        
        if self.isSwitchOn {
            var wordsInSection: [(key:String, value:Int)] = []
            let sectionTitle = self.alphabetArray[indexPath.section]
            
            for (word, numberOfOccurrences) in wordsFrequencyArray {
                let array = Array(word.characters)
                if array[0] == sectionTitle {
                    wordsInSection.append((key: word, value: numberOfOccurrences))
                }
            }
            let word = wordsInSection[indexPath.row].key
            let frequency = wordsInSection[indexPath.row].value
            
            cell.textLabel?.text = ("\(word) (\(frequency))")
        } else {
            
            var wordsWithGivenFrequency: [String] = []
            let sectionTitle = Array(self.frequencyArray)[indexPath.section]
            
            for (word,numberOfOccurrences) in wordsFrequencyArray {
                if numberOfOccurrences == Int(sectionTitle) {
                    wordsWithGivenFrequency.append(word)
                }
            }
            let word = wordsWithGivenFrequency[indexPath.row]
            
            cell.textLabel?.text = ("\(word)")
        }
        
        return cell
    }
    
    //MARK: - Actions
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("Currently sorting alphabetically.")
            self.isSwitchOn = true
        }
        else {
            print("Currently sorting by word frequency.")
            self.isSwitchOn = false
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
