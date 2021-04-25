//
//  QuestionsModel.swift
//  games
//
//  Created by Leticia Personal on 26/03/2021.
//

import Foundation

struct QuestionsModel: Decodable {
    let responseCode: Int
    let results: [QuestionModel]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

struct QuestionModel: Decodable {
    
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let answer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case answer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
    
    func getQuestion() -> String {
        String(describing: question.cString(using: .utf8))
    }
}

enum QuestionCategory: Int, CaseIterable {
    case generalKnowledge = 9
    case books = 10
    case films = 11
    case music = 12
    case musicalsTheaters = 13
    case television = 14
    case videoGames = 15
    case boardGames = 16
    case scienceNature = 17
    case scienceComputers = 18
    case scienceMathematics = 19
    case mythology = 20
    case sports = 21
    case geography = 22
    case history = 23
    case politics = 24
    case art = 25
    case celebrities = 26
    case animals = 27
    case vehicles = 28
    case comics = 29
    case scienceGadgets = 30
    case manga = 31
    case cartoons = 32
    
    func getName() -> String {
        switch self {
        case .generalKnowledge:
            return "General Knowledge"
        case .books:
            return "Books"
        case .films:
            return "Films"
        case .music:
            return "Music"
        case .musicalsTheaters:
            return "Musicals & Theatres"
        case .television:
            return "Television"
        case .videoGames:
            return "Video Games"
        case .boardGames:
            return "Board Games"
        case .scienceNature:
            return "Science & Nature"
        case .scienceComputers:
            return "Science: Computers"
        case .scienceMathematics:
            return "Science: Mathematics"
        case .mythology:
            return "Mythology"
        case .sports:
            return "Sports"
        case .geography:
            return "Geography"
        case .history:
            return "History"
        case .politics:
            return "Politics"
        case .art:
            return "Art"
        case .celebrities:
            return "Celebrities"
        case .animals:
            return "Animals"
        case .vehicles:
            return "Vehicles"
        case .comics:
            return "Comics"
        case .scienceGadgets:
            return "Science: Gadgets"
        case .manga:
            return "Japanese Anime & Manga"
        case .cartoons:
            return "Cartoon & Animations"
        }
    }
}
