//
//  Question.swift
//  PersonalityQuiz
//
//  Updated with Stretch Goals Support
//

import Foundation

// MARK: - Quiz Types (Stretch Goal 1)
enum QuizType: String, CaseIterable {
    case codingStyle = "What's Your Coding Style?"
    case animalPersonality = "What Animal Are You?"
    case careerPath = "What Career Suits You?"
    
    var title: String {
        return self.rawValue
    }
    
    var subtitle: String {
        switch self {
        case .codingStyle:
            return "Discover your programming personality"
        case .animalPersonality:
            return "Find out which animal matches your traits"
        case .careerPath:
            return "Explore careers that fit your style"
        }
    }
}

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
    var type: PersonalityType
}

// MARK: - Personality Results (Updated for multiple quizzes)
protocol PersonalityType {
    var rawValue: String { get }
    var definition: String { get }
    var emoji: String { get }
}

// Coding Style personalities
enum CodingStyle: String, CaseIterable, PersonalityType {
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

// Animal personalities (Stretch Goal 1)
enum AnimalType: String, CaseIterable, PersonalityType {
    case dog = "The Loyal Dog"
    case cat = "The Independent Cat"
    case eagle = "The Visionary Eagle"
    case dolphin = "The Social Dolphin"
    
    var definition: String {
        switch self {
        case .dog:
            return "You're loyal, enthusiastic, and thrive in team environments. Your energy and dedication inspire others!"
        case .cat:
            return "You value independence and work best with autonomy. You're selective about your commitments but deeply committed when you engage."
        case .eagle:
            return "You have a big-picture perspective and strategic mindset. You soar above the details to see opportunities others miss."
        case .dolphin:
            return "You're highly social and collaborative. Your emotional intelligence and communication skills make you a natural team player."
        }
    }
    
    var emoji: String {
        switch self {
        case .dog: return "🐕"
        case .cat: return "🐱"
        case .eagle: return "🦅"
        case .dolphin: return "🐬"
        }
    }
}

// Career personalities (Stretch Goal 1)
enum CareerType: String, CaseIterable, PersonalityType {
    case creative = "The Creative"
    case analyst = "The Analyst"
    case leader = "The Leader"
    case helper = "The Helper"
    
    var definition: String {
        switch self {
        case .creative:
            return "You excel in roles requiring innovation and artistic expression. Design, media, and creative problem-solving energize you."
        case .analyst:
            return "You thrive on data, logic, and systematic thinking. Research, finance, and technical roles are your sweet spot."
        case .leader:
            return "You're a natural at motivating and organizing others. Management, entrepreneurship, and strategic roles suit you perfectly."
        case .helper:
            return "You find fulfillment in supporting and improving others' lives. Teaching, healthcare, and social services align with your values."
        }
    }
    
    var emoji: String {
        switch self {
        case .creative: return "🎨"
        case .analyst: return "📊"
        case .leader: return "👔"
        case .helper: return "❤️"
        }
    }
}

// MARK: - Quiz Result (Stretch Goal 4: History)
struct QuizResult: Codable {
    let quizType: String
    let result: String
    let emoji: String
    let date: Date
    let score: String
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
