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
        if let quizData = readLocalFile(forName: "quiz") {
            let decoder = JSONDecoder()
                        
            do {
                let model = try decoder.decode(QuizModel.self, from: quizData)
                completion(model, nil)
                
            } catch {
                completion(nil, error)
            }
        }
    }
}
