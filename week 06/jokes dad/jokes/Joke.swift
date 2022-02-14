//
//  Joke.swift
//  jokes
//
//  Created by Aileen Pierce
//

import Foundation

struct Joke: Decodable {
    let setup: String
    let punchline: String
}

struct JokeData: Decodable {
    var body = [Joke]()
}


