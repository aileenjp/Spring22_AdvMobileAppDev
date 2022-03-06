//
//  ViewController.swift
//  Recipes
//
//  Created by Aileen Pierce
//

import UIKit

class AddRecipeViewController: UIViewController {
    var addedrecipe = String()
    var addedurl = String()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savesegue"{
            if nameTextField.text?.isEmpty == false {
                addedrecipe = nameTextField.text!
                addedurl = urlTextField.text!
            }
        }
    }

}

