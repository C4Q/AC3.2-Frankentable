//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenTableViewController: UITableViewController {
    
    let identifier = "FrankenIdentifier"
    var dataArray = [Int]()
    var headers = [Character]()
    var returnDict = [String:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let text = getTextFromData()
        let _ = counterOfUniqueWords(input: text)
    }

    // MARK: - Methods
    func counterOfUniqueWords(input: String) -> [String:Int] {
        var punctuationSeparators = CharacterSet()
        punctuationSeparators.insert(charactersIn: ".,?!:;&()*+-`_' \n")
        let wordsArray = input.lowercased().components(separatedBy: punctuationSeparators).filter { $0 != "" }
        for word in wordsArray {
             returnDict[word] = (returnDict[word] ?? 0) + 1
        }
        let sortedDict = returnDict.sorted { (a, b) -> Bool in
            a.value < b.value
        }
        print(sortedDict)
        return returnDict
    }
    
    func getTextFromData() -> String {
            let url = Bundle.main.url(forResource: "Data", withExtension: "txt")
            let data = try? Data(contentsOf: url!)
            let textString = String(data: data!, encoding: .utf8)
            print(textString)
        return textString!
        }
    
    func createAlphabetArray() {
        for letter in "abcdefghijklmnopqrstuvwxyz".characters {
            headers.append(letter)
        }
    }
 
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 26
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return returnDict.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FrankenIdentifier", for: indexPath)
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    }

}
