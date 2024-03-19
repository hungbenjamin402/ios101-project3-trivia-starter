//
//  ViewController.swift
//  Trivia
//
//  Created by benjamin on 3/11/24.
//

import UIKit

class ViewController: UIViewController {
    private var questions: [TriviaQuestion] = []
    private var currentQuestionIndex = 0
    private var userScore = 0
    
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var currentQuestion: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var questionDisplay: UITextView!
    @IBOutlet weak var answerOneDisplay: UIButton!
    @IBOutlet weak var answerTwoDisplay: UIButton!
    @IBOutlet weak var answerThreeDisplay: UIButton!
    @IBOutlet weak var answerFourDisplay: UIButton!
    @IBOutlet weak var scoreDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuestions()
    }
    
    private func fetchQuestions() {
        fetchTriviaQuestions { [weak self] questions in
            DispatchQueue.main.async {
                if let questions = questions {
                    self?.questions = questions
                    self?.currentQuestionIndex = 0
                    self?.updateUI()
                }
            }
        }
    }
    
    private func updateUI() {
        if currentQuestionIndex < questions.count {
            let currentQuestion = questions[currentQuestionIndex]
            questionNumber.text = "Question \(currentQuestionIndex + 1)/\(questions.count)"
            topicLabel.text = "Category: \(currentQuestion.category)"
            questionDisplay.text = currentQuestion.question.decodingHTMLEntities()
            let answers = [currentQuestion.correct_answer] + currentQuestion.incorrect_answers
            let shuffledAnswers = answers.shuffled()
            
            answerOneDisplay.setTitle(answers[0].decodingHTMLEntities(), for: .normal)
            answerTwoDisplay.setTitle(answers[1].decodingHTMLEntities(), for: .normal)
            answerThreeDisplay.setTitle(answers[2].decodingHTMLEntities(), for: .normal)
            answerFourDisplay.setTitle(answers[3].decodingHTMLEntities(), for: .normal)
            
            scoreDisplay.text = "Score: \(userScore)"
        } else {
            currentQuestionIndex = 0 // Or show a completion message, etc.
        }
    }
    
    @IBAction func answerButtonClick(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        
        if sender.title(for: .normal) == currentQuestion.correct_answer {
            userScore += 1
        }
        currentQuestionIndex += 1
        updateUI()
    }
}

extension String {
    func decodingHTMLEntities() -> String {
        guard let data = self.data(using: .utf8) else { return self }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        let decodedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil).string
        return decodedString ?? self
    }
}
