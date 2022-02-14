//
//  ViewController.swift
//  jokes
//
//  Created by Aileen Pierce
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var jokeTableView: UITableView!
    
    var jokes = [Joke]()
    var jokeDataHandler = JokeDataHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ues test data
        // loadtestdata()
        getAPIdata()
    }

    func getAPIdata() {
        //jokeDataHandler.onDataUpdate = {[weak self] (data:[Joke]) in self?.render()}
        Task {
            await jokeDataHandler.loadjson()
            jokes = jokeDataHandler.getJokes()
            jokeTableView.reloadData()
            print("Number of jokes \(jokes.count)")
        }
    }
    
    func loadtestdata() {
        let joke1 = Joke(setup: "Bad at golf?", punchline: "Join the club.")
        let joke2 = Joke(setup: "French fries are not made in France.", punchline: "They are actually made in Grease.")
        let joke3 = Joke(setup: "What do you call a really dumb zipper?", punchline: "A zipshit.")

        jokes.append(joke1)
        jokes.append(joke2)
        jokes.append(joke3)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jokes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath)
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = jokes[indexPath.row].setup
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: jokes[indexPath.row].setup, message: jokes[indexPath.row].punchline, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Haha", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //deselects the row that had been choosen
    }

}

