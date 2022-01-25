//
//  DataLoader.swift
//  scrabbleQ
//
//  Created by Aileen Pierce
//

import Foundation

class DataLoader {

    var allData = [GroupedWords]()

    func loadData(fileName: String){
        // URL for our plist
        if let pathURL = Bundle.main.url(forResource: fileName, withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                allData = try plistdecoder.decode([GroupedWords].self, from: data)
            } catch {
                // handle error
                print(error)
            }
        }
    }

    func getWords()->[GroupedWords]{
        return allData
    }
    
    func getLetters()->[String]{
        var letters = [String]()
        for firstLetter in allData{
            letters.append(firstLetter.letter)
        }
        // sorts the array
        letters.sort(by: {$0 < $1})
        return letters
    }
    
}

