//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by benjamin on 3/18/24.
//

import Foundation

// Define the struct to represent each question and the JSON response
struct TriviaQuestion: Decodable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

struct TriviaResponse: Decodable {
    let response_code: Int
    let results: [TriviaQuestion]
}

// Function to fetch and parse trivia questions
func fetchTriviaQuestions(completion: @escaping ([TriviaQuestion]?) -> Void) {
    let urlString = "https://opentdb.com/api.php?amount=10&difficulty=easy"
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        completion(nil)
        return
    }

    var request = URLRequest(url: url, timeoutInterval: Double.infinity)
    request.addValue("PHPSESSID=8eb396c017507f0ec0be146e055b67a4", forHTTPHeaderField: "Cookie")
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error fetching data: \(error)")
            completion(nil)
            return
        }

        guard let data = data else {
            print("No data received")
            completion(nil)
            return
        }

        do {
            let decodedData = try JSONDecoder().decode(TriviaResponse.self, from: data)
            if decodedData.response_code == 0 { // Checking if the response is successful
                completion(decodedData.results)
            } else {
                print("Invalid response code: \(decodedData.response_code)")
                completion(nil)
            }
        } catch {
            print("Error parsing data: \(error)")
            completion(nil)
        }
    }

    task.resume()
}
