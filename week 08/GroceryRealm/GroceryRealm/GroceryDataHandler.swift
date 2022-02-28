//
//  GroceryDataHandler.swift
//  GroceryRealm
//
//  Created by Aileen Pierce
//

import Foundation
import RealmSwift

class GroceryDataHandler {
    var myRealm : Realm!  //Realm database instance
    var groceryData: Results<Grocery> //collection of Objects
    {
        get {
            return myRealm.objects(Grocery.self) //returns all Grocery objects from Realm
        }
    }

    func dbSetup(){
        //initialize the Realm database
        do {
            myRealm = try Realm()
        } catch let error {
            print(error.localizedDescription)
        }
    print(Realm.Configuration.defaultConfiguration.fileURL!) //prints location of Realm database
    }
    
    func addItem(newItem:Grocery){
        do {
            try myRealm.write({
                myRealm.add(newItem) //add to realm database
            })
        } catch let error{
            print(error.localizedDescription)
        }
    }

    func boughtItem(item: Grocery){
        do {
            try myRealm.write ({
                item.bought = !item.bought
            })
        }catch let error{
            print(error.localizedDescription)
        }
    }

    func deleteItem(item: Grocery){
        do {
            try myRealm.write ({
                myRealm.delete(item) //delete from realm database
            })
        } catch let error{
            print(error.localizedDescription)
        }
    }

    func getGroceries()->[Grocery]{
        return Array(groceryData)
    }
}

