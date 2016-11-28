//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenTableViewController: UITableViewController {

    var arrayOfText = [String: Int]()
    var nameOfHeader = [Character]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "Data", withExtension: "txt"),
            let data = try? Data(contentsOf: url),
            let text = String(data: data, encoding: .utf8){
            
            getValue(text: text)
            theHeader()
            
        }

    }
    
    func getValue(text: String){
        
        var punctuation = CharacterSet()
        punctuation.insert(charactersIn: ".,?!:;&()*+-@#$%^`~_<>'0123456789\n ")
        
        let textInLine: [String] = text.lowercased().components(separatedBy: punctuation)
        let sortedText: [String] = textInLine.filter{$0 != ""}
        
        //Put individual text into the dictionary
        
        for word in sortedText{
            if arrayOfText[word] == nil{
                arrayOfText[word] = 1
            }else{
                arrayOfText[word] = arrayOfText[word]! + 1
            }
        }

//        var sortedArrayOfText = Array(arrayOfText.sorted{$0.value > $1.value})
        
    }
    
    func theHeader(){
    let alphabet = "abcdefghijklmnopqrstuvwxyz".characters
        for i in alphabet{
            nameOfHeader.append(i)
        }
    
    }

    // MARK: - Table view data source
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return nameOfHeader.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfText.filter{$0.key.characters.first == nameOfHeader[section]}.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        
        let char = arrayOfText.filter{$0.key.characters.first == nameOfHeader[indexPath.section]}.sorted { $0.value > $1.value}
        cell.textLabel?.text = "\(char[indexPath.row].key) = \(char[indexPath.row].value)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        print("Name of the header: \(nameOfHeader[section])")
        return String(nameOfHeader[section])
    }

   

}
