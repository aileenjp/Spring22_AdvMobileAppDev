//
//  ViewController.swift
//  scrabbleQ
//
//  Created by Aileen Pierce
//

import UIKit

class ViewController: UITableViewController {
    
    var words = [GroupedWords]()
    var letters = [String]()
    var data = DataLoader()
    let wordFile = "qwordswithoutu3"
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        data.loadData(fileName: wordFile)
        words=data.getWords()
        letters=data.getLetters()
        
        //search results
        let resultsController = SearchResultsController() //create an instance of our SearchResultsController class
        resultsController.allwords = words //set the allwords property to our words array
        searchController = UISearchController(searchResultsController: resultsController) //initialize our search controller with the resultsController when it has search results to display
        
        //search bar configuration
        searchController.searchBar.placeholder = "Enter a search term" //place holder text
        searchController.searchBar.sizeToFit() //sets appropriate size for the search bar
        tableView.tableHeaderView=searchController.searchBar //install the search bar as the table header
        searchController.searchResultsUpdater = resultsController //sets the instance to update search results

    }

    // Required methods for UITableViewDataSource
    // Customize the number of rows in the section

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words[section].words.count
    }
    
    // Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let wordsSection = words[section].words
        //dequeues an existing cell if one is available, or creates a new one and adds it to the table
        let cell = tableView.dequeueReusableCell(withIdentifier: "scrabbleCell", for: indexPath)
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = wordsSection[indexPath.row]
        cell.contentConfiguration = cellConfig
        // tableView.rowHeight = 44.0 //default row height
        return cell
    }

    //UITableViewDelegate method that is called when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let wordsSection = words[section].words
        let alert = UIAlertController(title: "Row selected", message: "You selected \(wordsSection[indexPath.row])", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //deselects the row that had been choosen
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return letters.count
    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return letters[section]
//    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letters
    }
    
    //custom header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = UITableViewHeaderFooterView()
        var headerConfig = headerview.defaultContentConfiguration()
        headerConfig.textProperties.font = UIFont(name: "Helvetica", size: 20)!
        headerConfig.textProperties.alignment = .center
        headerConfig.text = letters[section]
        headerConfig.image = UIImage(named: "scrabble_q30")
        headerview.contentConfiguration = headerConfig
        return headerview
    }
}

