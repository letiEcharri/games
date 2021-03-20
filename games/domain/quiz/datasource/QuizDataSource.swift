//
//  QuizDataSource.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

class QuizDataSource: DataSource, QuizDataSourceProtocol {
    
    static let shared: QuizDataSourceProtocol = QuizDataSource()
    
    func getQuiz(completion: @escaping QuizResponseBlock) {
        FirebaseManager.getValue(from: .quiz) { (response, error) in
            if let quiz = response as? [String: Any] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: quiz, options: .prettyPrinted)
                    let model = try JSONDecoder().decode(QuizCategoriesModel.self, from: jsonData)
                    completion(model, nil)

                } catch {
                    completion(nil, error)
                }
            } else if let quizData = self.readLocalFile(forName: "quiz") {
                do {
                    let model = try JSONDecoder().decode(QuizModel.self, from: quizData)
                    completion(model.quiz, nil)

                } catch {
                    completion(nil, error)
                }
            }
        }
    }
}
