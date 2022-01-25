//
//  DataLoader.swift
//  scrabbleQ
//
//  Created by Aileen Pierce
//

import Foundation

class DataLoader {

    var qNoUWords = [String]()

    func loadData(fileName: String){
        // URL for our plist
        if let pathURL = Bundle.main.url(forResource: fileName, withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                qNoUWords = try plistdecoder.decode([String].self, from: data)
            } catch {
                // handle error
                print(error)
            }
        }
    }

    func getWords()->[String]{
        return qNoUWords
    }
    
}

