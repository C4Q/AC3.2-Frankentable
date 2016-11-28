//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenTableViewController: UITableViewController {

    var allWords = [String: Int]()
    var char = [Character]()
    var identifier = "Frank Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.main.url(forResource: "Data", withExtension: "txt"),
            let data = try? Data(contentsOf: url),
            let text = String(data: data, encoding: .utf8) {
            
            // here's your text
            print(text)
            organized(text: text)

            for chars in "abcdefghijklmnopqrstuvwxyz".characters {
                char.append(chars)
                
        }
    }

    
    
    }
    
       func organized(text: String) {
               var punctuation = CharacterSet()
                punctuation.insert(charactersIn: ".,?!:;&()*+-@#$%^'~_<>` \n")
                let wordArr = text.lowercased().components(separatedBy: punctuation).filter { !$0.isEmpty }
        
                for word in wordArr {
                       allWords[word] = (allWords[word] ?? 0) + 1
                   }
           }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 26
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allWords.filter({ $0.key.characters.first == char[section] }).count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        let words = allWords.filter({ $0.key.characters.first == char[indexPath.section] }).sorted { $0.value > $1.value }
                cell.textLabel?.text = "\(words[indexPath.row].key) - \(words[indexPath.row].value)"
        

        return cell
    }
 

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(char[section] )
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
