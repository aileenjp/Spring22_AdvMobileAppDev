//
//  JokeDataHandler.swift
//  jokes
//
//  Created by Aileen Pierce
//

import Foundation

class JokeDataHandler {
    var jokeData = JokeData()
    
    func loadjson() async {
        //based on API documentation
        //https://rapidapi.com/KegenGuyll/api/dad-jokes/
        
        let headers = [
            "x-rapidapi-key": "09f9c252f0msh84e015c0d48e793p1e3311jsnb44f6cd4ae10",
            "x-rapidapi-host": "dad-jokes.p.rapidapi.com"
        ]
        
        let urlPath = "https://dad-jokes.p.rapidapi.com/random/joke?count=5"
        guard let url = URL(string: urlPath)
            else {
                print("url error")
                return
            }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard (response as? HTTPURLResponse)?.statusCode == 200
                else {
                    print("file download error")
                    return
                }
            //download successful
            print("download complete")
            parsejson(data)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func parsejson (_ data: Data) {
        do
        {
            let apiData = try JSONDecoder().decode(JokeData.self, from: data)
            for joke in apiData.body
            {
                jokeData.body.append(joke)
                print(joke)
            }
            print("number of jokes parsed \(jokeData.body.count)")
            print("parsejson done")
        }
        catch let jsonErr
        {
            print(jsonErr.localizedDescription)
            return
        }
    }

    func getJokes() -> [Joke] {
        return jokeData.body
    }
}
