//
//  QuestionBank.swift
//  Trivia
//
//  Created by benjamin on 3/11/24.
//

import Foundation

struct QuestionBank {
    let topic: String
    let question: String
    let pickAnswer: [String]
    let correctAnswer: String
    
    static let access: [QuestionBank] = [
        QuestionBank(topic: "General Knowledge", question: "What is the capital of France?",
                         pickAnswer: ["Paris", "Berlin", "Madrid", "Lisbon"],
                         correctAnswer: "Paris"),
            QuestionBank(topic: "Science", question: "What is the chemical symbol for water?",
                         pickAnswer: ["H2O", "CO2", "NaCl", "O2"],
                         correctAnswer: "H2O"),
            QuestionBank(topic: "History", question: "Who was the first President of the United States?",
                         pickAnswer: ["Abraham Lincoln", "George Washington", "Thomas Jefferson", "John Adams"],
                         correctAnswer: "George Washington"),
            QuestionBank(topic: "Geography", question: "Which is the largest ocean on Earth?",
                         pickAnswer: ["Atlantic Ocean", "Indian Ocean", "Arctic Ocean", "Pacific Ocean"],
                         correctAnswer: "Pacific Ocean"),
            QuestionBank(topic: "Sports", question: "Which country hosted the 2016 Summer Olympics?",
                         pickAnswer: ["China", "Brazil", "Russia", "Japan"],
                         correctAnswer: "Brazil")
    ]
}
