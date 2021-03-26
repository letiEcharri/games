//
//  OpenTrivialDataBase.swift
//  games
//
//  Created by Leticia Personal on 26/03/2021.
//

import Foundation

typealias QuestionsResponseBlock = ([QuestionModel]?, Error?) -> Void

protocol OpenTrivialDataBase: DataSource {
    func requestQuestions(with model: OpenTrivialRequestModel, completion: @escaping QuestionsResponseBlock)
}

extension OpenTrivialDataBase {
    var trivialURLbase: String {
        "https://opentdb.com/api.php"
    }
    
    func requestQuestions(with model: OpenTrivialRequestModel, completion: @escaping QuestionsResponseBlock) {
        
        if var urlComponents = URLComponents(string: trivialURLbase) {
            urlComponents.queryItems = model.getParameters()
            
            guard let url = urlComponents.url else {
                return
            }
            
            executeRequest(url: url) { (response) in
                
                if let data = response as? Data {
                    do {
                        let questions = try JSONDecoder().decode(QuestionsModel.self, from: data)
                        let formatQuestions = questions.results.compactMap({ item in
                            return QuestionModel(category: item.category, type: item.type, difficulty: item.difficulty, question: item.question.formatted(), answer: item.answer.formatted(), incorrectAnswers: format(item.incorrectAnswers))
                        })
                        completion(formatQuestions, nil)
                    } catch {
                        completion(nil, error)
                    }
                    
                } else {
                    let error = NSError(domain:"", code: 0, userInfo:[ NSLocalizedDescriptionKey: "Questions error - no data"]) as Error
                    completion(nil, error)
                }
                
            } failure: { (error) in
                completion(nil, error)
            }
            
        }
    }
    
    private func format(_ questions: [String]) -> [String] {
        return questions.compactMap({ $0.formatted() })
    }
    
}

struct OpenTrivialRequestModel {
    var amount: Int = 5
    var category: QuestionCategory?
    var difficulty: String = "easy"
    var type: String = "multiple"
    
    func getParameters() -> [URLQueryItem] {
        var params = [
            URLQueryItem(name: "amount", value: String(amount)),
            URLQueryItem(name: "difficulty", value: difficulty),
            URLQueryItem(name: "type", value: type)
        ]
        if let category = category {
            params.append(URLQueryItem(name: "category", value: String(category.rawValue)))
        }
        return params
    }
}
