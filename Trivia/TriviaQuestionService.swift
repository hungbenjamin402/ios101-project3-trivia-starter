//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by benjamin on 3/16/24.
//

import Foundation

struct TriviaQuestion: Decodable {
    let question: String
    let correctAnswer: String
    let category: String
    
}

class TriviaQuestionService {
    // Base URL of the trivia API
    private let baseURL = "https://opentdb.com/api.php"

    // Function to fetch trivia questions
    func fetchTriviaQuestions(completion: @escaping ([TriviaQuestion]?, Error?) -> Void) { //
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "amount", value: "10"),
            URLQueryItem(name: "type", value: "boolean")
        ]
        
        guard let url = urlComponents?.url else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("PHPSESSID=3ef05240afee422205b9c7d0cb824dc2", forHTTPHeaderField: "Cookie")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"]))
                return
            }
            
            do {
                // Parse the JSON data
                let triviaQuestions = try JSONDecoder().decode([TriviaQuestion].self, from: data)
                completion(triviaQuestions, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
