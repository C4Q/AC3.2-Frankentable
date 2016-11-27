//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenTableViewController: UITableViewController {
    
    var identifier = "WordCell"
    var wordDict = [String:Int]()
    var countDict = [String:Int]()
    var abc = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "Data", withExtension: "txt"),
            let data = try? Data(contentsOf: url),
            let text = String(data: data, encoding: .utf8) {
            setupABC()
            organizeWords(text: text)
            dump(wordDict.filter{ $0.key.characters.first == "a" })
        }
    }
    
    func setupABC() {
        for char in "abcdefghijklmnopqrstuvwxyz".characters {
            abc.append(char)
        }
    }
    
    func organizeWords(text: String) {
        var punctuation = CharacterSet()
        punctuation.insert(charactersIn: ".,?!:;&()*+-@#$%^'~_<>` \n")
        let wordArr = text.lowercased().components(separatedBy: punctuation).filter { !$0.isEmpty }
        
        for word in wordArr {
            wordDict[word] = (wordDict[word] ?? 0) + 1
        }
    }
    
    // MARK: - Table view data source
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 26
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(abc[section])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordDict.filter({ $0.key.characters.first == abc[section] }).count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FrankenTableViewCell
        let words = wordDict.filter({ $0.key.characters.first == abc[indexPath.section] }).sorted { $0.value > $1.value }
        cell.wordTextLabel.text = "\(words[indexPath.row].key) - \(words[indexPath.row].value)"
        
        return cell
    }
    
    
}
