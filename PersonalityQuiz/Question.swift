//
//  Question.swift
//  PersonalityQuiz
//
//  Created by Claude
//

import Foundation

// Represents different answer types
enum ResponseType {
    case single, multiple, ranged
}

// Represents a single question
struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

// Represents a single answer
struct Answer {
    var text: String
    var type: CodingStyle
}

// The possible personality results
enum CodingStyle: String, CaseIterable {
    case architect = "The Architect"
    case hacker = "The Hacker"
    case perfectionist = "The Perfectionist"
    case pragmatist = "The Pragmatist"
    
    var definition: String {
        switch self {
        case .architect:
            return "You love planning, designing, and creating well-structured solutions. Clean architecture is your passion!"
        case .hacker:
            return "You thrive on experimentation and quick solutions. Get it working first, optimize later!"
        case .perfectionist:
            return "Every line of code matters. You believe in best practices, testing, and code that reads like poetry."
        case .pragmatist:
            return "You balance speed and quality. Shipping working software that solves real problems is your goal."
        }
    }
    
    var emoji: String {
        switch self {
        case .architect: return "🏗️"
        case .hacker: return "💻"
        case .perfectionist: return "✨"
        case .pragmatist: return "⚡"
        }
    }
}
