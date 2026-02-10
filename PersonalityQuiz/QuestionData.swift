//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Claude
//

import Foundation

struct QuestionData {
    static let questions: [Question] = [
        Question(
            text: "When starting a new project, what's your first move?",
            type: .single,
            answers: [
                Answer(text: "Sketch out the architecture and plan the structure", type: .architect),
                Answer(text: "Start coding immediately and figure it out as I go", type: .hacker),
                Answer(text: "Research best practices and set up the perfect development environment", type: .perfectionist),
                Answer(text: "Define the minimum viable product and get something working", type: .pragmatist)
            ]
        ),
        Question(
            text: "How do you feel about code comments?",
            type: .single,
            answers: [
                Answer(text: "Essential for explaining the why behind design decisions", type: .architect),
                Answer(text: "Only when absolutely necessary - code should be self-explanatory", type: .hacker),
                Answer(text: "Detailed comments following documentation standards", type: .perfectionist),
                Answer(text: "Enough to help the next person understand the code quickly", type: .pragmatist)
            ]
        ),
        Question(
            text: "Which of these activities do you enjoy most? (Choose all that apply)",
            type: .multiple,
            answers: [
                Answer(text: "Refactoring legacy code", type: .architect),
                Answer(text: "Building quick prototypes", type: .hacker),
                Answer(text: "Writing comprehensive unit tests", type: .perfectionist),
                Answer(text: "Shipping features that users love", type: .pragmatist)
            ]
        ),
        Question(
            text: "A bug appears in production. What do you do?",
            type: .single,
            answers: [
                Answer(text: "Analyze the root cause and fix the underlying design flaw", type: .architect),
                Answer(text: "Quick hotfix now, proper solution later", type: .hacker),
                Answer(text: "Write a test that reproduces the bug, then fix it properly", type: .perfectionist),
                Answer(text: "Fix it in the simplest way that prevents it from happening again", type: .pragmatist)
            ]
        ),
        Question(
            text: "How important is code formatting to you?",
            type: .ranged,
            answers: [
                Answer(text: "Not important - functionality matters more", type: .hacker),
                Answer(text: "Somewhat important - I follow team standards", type: .pragmatist),
                Answer(text: "Very important - consistency is key", type: .architect),
                Answer(text: "Critical - I use auto-formatters and linters religiously", type: .perfectionist)
            ]
        ),
        Question(
            text: "What's your attitude toward deadlines?",
            type: .single,
            answers: [
                Answer(text: "Plan carefully to deliver quality work on time", type: .architect),
                Answer(text: "Work intensely to ship whatever works by the deadline", type: .hacker),
                Answer(text: "Push back if quality would be compromised", type: .perfectionist),
                Answer(text: "Balance scope and quality to meet the deadline", type: .pragmatist)
            ]
        )
    ]
}
