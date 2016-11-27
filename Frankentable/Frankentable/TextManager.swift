//
//  TextManager.swift
//  Frankentable
//
//  Created by Ana Ma on 11/27/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation
import UIKit

class TextManager {
    
    static let manager: TextManager = TextManager()
    
    func words(str: String) -> [String:Int] {
        var punctuationSeperators = CharacterSet()
        punctuationSeperators.insert(charactersIn: ".,?!:;()&*+-@#$%^`~_<>'0123456789 ")
        
        let wordArray = str.lowercased().components(separatedBy: punctuationSeperators)
        let filterWordArray = wordArray.filter {$0 != ""}
        
        var frequencyDictionary = [String: Int]()
        
        for word in filterWordArray {
            frequencyDictionary[word] = (frequencyDictionary[word] ?? 0) + 1
        }
        return frequencyDictionary
    }
    
    func sortByAlphabet (arr: [String]) -> [String:[String]] {
        var alphabetDictionary: [String:[String]] = [:]
        for word in arr {
            let firstcharOfStr = String(word.characters.prefix(1))
            if alphabetDictionary[firstcharOfStr] != nil {
                alphabetDictionary[firstcharOfStr]?.append(word)
            } else {
                alphabetDictionary[firstcharOfStr] = [word]
            }
        }
        return alphabetDictionary
    }
    
    func sortByCount (dict: [String: Int]) -> [Int:[String]] {
        var countDictionary: [Int:[String]] = [:]
        for (key,value) in dict {
            if countDictionary[value] != nil {
                countDictionary[value]?.append(key)
            } else {
                countDictionary[value] = [key]
            }
        }
        return countDictionary
    }
}
