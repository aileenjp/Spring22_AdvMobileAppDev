//
//  JokeDatahandler.swift
//  jokes
//
//  Created by Aileen Pierce
//

import Foundation

class JokeDataHandler {
    var jokeData = JokeData()
    
    func loadjson() async {
        //based on API documentation
        //https://sv443.net/jokeapi/v2/

        guard let urlPath = URL(string: "https://v2.jokeapi.dev/joke/Programming?type=twopart&amount=10")
            else {
                print("url error")
                return
            }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: urlPath, delegate: nil)
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
            for joke in apiData.jokes
            {
                jokeData.jokes.append(joke)
                print(joke)
            }
            print("number of jokes parsed \(jokeData.jokes.count)")
            print("parsejson done")
        }
        catch let jsonErr
        {
            print(jsonErr.localizedDescription)
            return
        }
    }

    func getJokes() -> [Joke] {
        return jokeData.jokes
    }
}
