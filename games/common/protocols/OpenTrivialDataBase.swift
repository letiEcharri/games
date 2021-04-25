//
//  OpenTrivialDataBase.swift
//  games
//
//  Created by Leticia Personal on 26/03/2021.
//

import Foundation

typealias QuestionsResponseBlock = ([QuestionModel]?, Error?) -> Void
typealias SessionTokenResponseBlock = (String?, Error?) -> Void

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
                let error = NSError(domain:"", code: 0, userInfo: [NSLocalizedDescriptionKey: "Questions error - url no valid"]) as Error
                completion(nil, error)
                return
            }
            
            executeRequest(url: url) { (response) in
                
                if let data = response as? Data {
                    do {
                        let questions = try JSONDecoder().decode(QuestionsModel.self, from: data)
                        guard let responseCode = OpenTrivialResponseCode(rawValue: questions.responseCode) else {
                            let error = NSError(domain:"", code: 1, userInfo: [NSLocalizedDescriptionKey: "Questions error - no data"])
                            completion(nil, error)
                            return
                        }
                        
                        if responseCode == .success {
                            let formatQuestions = questions.results.compactMap({ item in
                                return QuestionModel(category: item.category, type: item.type, difficulty: item.difficulty, question: item.question.formatted(), answer: item.answer.formatted(), incorrectAnswers: format(item.incorrectAnswers))
                            })
                            completion(formatQuestions, nil)
                            
                        } else {
                            let error = NSError(domain:"", code: responseCode.rawValue, userInfo: [NSLocalizedDescriptionKey: responseCode.getDescription()]) as Error
                            completion(nil, error)
                        }
                        
                    } catch {
                        completion(nil, error)
                    }
                    
                } else {
                    let error = NSError(domain:"", code: 0, userInfo: [NSLocalizedDescriptionKey: "Questions error - no data"]) as Error
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
    
    func retrieveSessionToken(completion: @escaping SessionTokenResponseBlock) {
        guard let url = URL(string: "https://opentdb.com/api_token.php?command=request") else {
            return
        }
        
        executeRequest(url: url) { (response) in
            
            if let data = response as? Data {
                
                do {
                    let questions = try JSONDecoder().decode(SessionTokenModel.self, from: data)
                    completion(questions.token, nil)
                } catch {
                    completion(nil, error)
                }
                
            } else {
                let error = NSError(domain:"", code: 0, userInfo: [NSLocalizedDescriptionKey: "Request token error - no data"]) as Error
                completion(nil, error)
            }
            
        } failure: { (error) in
            completion(nil, error)
        }

    }
    
}

struct OpenTrivialRequestModel {
    var amount: Int = 5
    var category: QuestionCategory?
    var difficulty: String = "easy"
    var type: String = "multiple"
    var token: String?
    
    func getParameters() -> [URLQueryItem] {
        var params = [
            URLQueryItem(name: "amount", value: String(amount)),
            URLQueryItem(name: "difficulty", value: difficulty),
            URLQueryItem(name: "type", value: type)
        ]
        if let category = category {
            params.append(URLQueryItem(name: "category", value: String(category.rawValue)))
        }
        if let token = token {
            params.append(URLQueryItem(name: "token", value: token))
        }
        return params
    }
}

enum OpenTrivialResponseCode: Int {
    case success = 0
    case noResults = 1
    case invalidParameter = 2
    case tokenNotFound = 3
    case tokenEmpty = 4
    
    func getDescription() -> String {
        switch self {
        case .success:
            return "Returned results successfully"
        case .noResults:
            return "Could not return results."
        case .invalidParameter:
            return "Contains an invalid parameter"
        case .tokenNotFound:
            return "Session Token does not exist"
        case .tokenEmpty:
            return "Session Token has returned all possible questions for the specified query. Resetting the Token is necessary."
        }
    }
}
