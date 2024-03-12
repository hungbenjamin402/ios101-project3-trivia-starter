//
//  ViewController.swift
//  Trivia
//
//  Created by benjamin on 3/11/24.
//

import UIKit

class ViewController: UIViewController {
    private var questionBank: QuestionBank? // Not Initialize => Optional
    private var scrollingThroughQuestionBank = 0
    private var userScore = 0
    
    @IBOutlet weak var currentQuestion: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var questionDisplay: UITextView!
    @IBOutlet weak var answerOneDisplay: UIButton!
    @IBOutlet weak var answerTwoDisplay: UIButton!
    @IBOutlet weak var answerThreeDisplay: UIButton!
    @IBOutlet weak var answerFourDisplay: UIButton!
    
    @IBOutlet weak var scoreDisplay: UILabel!
    
    private var totalQuestions = QuestionBank.access.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreDisplay.text = "Score: \(userScore)"
        
        if scrollingThroughQuestionBank < totalQuestions {
            if !QuestionBank.access.isEmpty {
                questionBank = QuestionBank.access[scrollingThroughQuestionBank]
                
                currentQuestion.text = "Question \(scrollingThroughQuestionBank)/\(totalQuestions)"
                
                
                if let topic = questionBank?.topic {
                    topicLabel.text = "Topic: \(topic)"
                }
                
                questionDisplay.text = questionBank?.question
                
                answerOneDisplay.setTitle(questionBank?.pickAnswer[0], for: .normal)
                answerTwoDisplay.setTitle(questionBank?.pickAnswer[1], for: .normal)
                answerThreeDisplay.setTitle(questionBank?.pickAnswer[2], for: .normal)
                answerFourDisplay.setTitle(questionBank?.pickAnswer[3], for: .normal)
                
            }
        }
        else {
            scrollingThroughQuestionBank = 0
            self.viewDidLoad()
        }
    }
    
    @IBAction func answerOneClick(_ sender: UIButton) {
        if questionBank?.pickAnswer[0] == questionBank?.correctAnswer {
            userScore += 1
            scrollingThroughQuestionBank += 1
        }
        self.viewDidLoad()
    }
    
    @IBAction func answerTwoClick(_ sender: UIButton) {
        if questionBank?.pickAnswer[1] == questionBank?.correctAnswer {
            userScore += 1
            scrollingThroughQuestionBank += 1
        }
        self.viewDidLoad()
    }
    
    @IBAction func answerThreeClick(_ sender: UIButton) {
        if questionBank?.pickAnswer[2] == questionBank?.correctAnswer {
            userScore += 1
            scrollingThroughQuestionBank += 1
        }
        self.viewDidLoad()
    }
    
    @IBAction func answerFourClick(_ sender: UIButton) {
        if questionBank?.pickAnswer[3] == questionBank?.correctAnswer {
            userScore += 1
            scrollingThroughQuestionBank += 1
        }
        self.viewDidLoad()
    }
}
