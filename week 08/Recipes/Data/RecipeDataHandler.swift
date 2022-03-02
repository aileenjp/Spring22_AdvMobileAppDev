//
//  RecipeDataHandler.swift
//  Recipes
//
//  Created by Aileen Pierce
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RecipeDataHandler {
    let db = Firestore.firestore()
    var recipeData = [Recipe]()
    
    func getFirebaseData() async {
        do {
            let snapshot = try await db.collection("recipes").getDocuments()
            self.recipeData = snapshot.documents.compactMap {document->Recipe? in
                return try? document.data(as: Recipe.self)
            }
            print(self.recipeData)
        }
        catch{
            print("Error fetching document: \(error.localizedDescription)")
        }
    }
                                
    func getRecipes()->[Recipe]{
        return recipeData
    }
    
    func addRecipe(name:String, url:String){
        let recipeCollection = db.collection("recipes")
        
        //create Dictionary
        let newRecipeDict = ["name": name, "url": url]
        
        // Add a new document with a generated id
        var ref: DocumentReference? = nil
        ref = recipeCollection.addDocument(data: newRecipeDict)
        {err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }

    func deleteRecipe(recipeID: String){
        // Delete the object from Firestore
        db.collection("recipes").document(recipeID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }

}

