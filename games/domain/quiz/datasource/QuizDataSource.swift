//
//  QuizDataSource.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

class QuizDataSource: QuizDataSourceProtocol {
    
    static let shared: QuizDataSourceProtocol = QuizDataSource()
    
    func getQuiz(completion: @escaping QuizResponseBlock) {
//        FirebaseManager.getValue(from: .quiz) { (response, error) in
//            if let quiz = response as? [String: Any] {
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: quiz, options: .prettyPrinted)
//                    let model = try JSONDecoder().decode(QuizCategoriesModel.self, from: jsonData)
//                    completion(model, nil)
//
//                } catch {
//                    completion(nil, error)
//                }
//            } else if let quizData = self.readLocalFile(forName: "quiz") {
//                do {
//                    let model = try JSONDecoder().decode(QuizModel.self, from: quizData)
//                    completion(model.quiz, nil)
//
//                } catch {
//                    completion(nil, error)
//                }
//            }
//        }
    }
    
    func getQuestions(with model: OpenTrivialRequestModel, completion: @escaping QuizCategoryResponseBlock) {
        requestQuestions(with: model) { (response, error) in
            
            if let questions = response {
                let newQuestions = self.parse(old: questions)
                let category = QuizCategoryModel(name: model.category?.getName() ?? "", questions: newQuestions)
                completion(category, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    private func parse(old questions: [QuestionModel]) -> [QuizQuestionModel] {
        var result: [QuizQuestionModel] = []

        for item in questions {
            var answersArray = item.incorrectAnswers
            answersArray.append(item.answer)
            answersArray.shuffle()
            let newAnswers = QuizCategoryAnswersModel(answer1: answersArray[0], answer2: answersArray[1], answer3: answersArray[2], answer4: answersArray[3])
            
            let new = QuizQuestionModel(id: 0, question: item.question, answers: newAnswers, answer: newAnswers.getRight(answer: item.answer))
            result.append(new)
        }
        
        return result
    }
}
