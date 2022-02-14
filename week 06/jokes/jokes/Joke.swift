//
//  Joke.swift
//  jokes
//
//  Created by Aileen Pierce
//

import Foundation

struct Joke: Decodable {
    let setup: String
    let delivery: String
}

struct JokeData: Decodable {
    var jokes = [Joke]()
}

