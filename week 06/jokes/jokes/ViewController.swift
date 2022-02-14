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
        // Do any additional setup after loading the view.
        // loadtestdata()
        getAPIdata()
    }

    func getAPIdata() {
        Task {
            await jokeDataHandler.loadjson()
            jokes = jokeDataHandler.getJokes()
            jokeTableView.reloadData()
            print("Number of jokes \(jokes.count)")
        }
    }
    
    func loadtestdata() {
        //test data
        let joke1 = Joke(setup: "What's the best thing about a Boolean?", delivery: "Even if you're wrong, you're only off by a bit.")
        let joke2 = Joke(setup: "What's the object-oriented way to become wealthy?", delivery: "Inheritance")
        let joke3 = Joke(setup: "If you put a million monkeys at a million keyboards, one of them will eventually write a Java program.", delivery: "the rest of them will write Perl")

        jokes.append(joke1)
        jokes.append(joke2)
        jokes.append(joke3)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView number of rows in section")
        print(jokes.count)
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableview cell for row at")
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath)
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = jokes[indexPath.row].setup
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: jokes[indexPath.row].setup, message: jokes[indexPath.row].delivery, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Haha", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //deselects the row that had been choosen
    }
    
}

