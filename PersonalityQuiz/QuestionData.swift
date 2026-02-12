//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Updated with Multiple Quiz Types (Stretch Goal 1)
//

import Foundation

struct QuestionData {
    
    // MARK: - Coding Style Questions
    static let codingStyleQuestions: [Question] = [
        Question(
            text: "When starting a new project, what's your first move?",
            type: .single,
            answers: [
                Answer(text: "Sketch out the architecture and plan the structure", type: CodingStyle.architect),
                Answer(text: "Start coding immediately and figure it out as I go", type: CodingStyle.hacker),
                Answer(text: "Research best practices and set up the perfect development environment", type: CodingStyle.perfectionist),
                Answer(text: "Define the minimum viable product and get something working", type: CodingStyle.pragmatist)
            ]
        ),
        Question(
            text: "How do you feel about code comments?",
            type: .single,
            answers: [
                Answer(text: "Essential for explaining the why behind design decisions", type: CodingStyle.architect),
                Answer(text: "Only when absolutely necessary - code should be self-explanatory", type: CodingStyle.hacker),
                Answer(text: "Detailed comments following documentation standards", type: CodingStyle.perfectionist),
                Answer(text: "Enough to help the next person understand the code quickly", type: CodingStyle.pragmatist)
            ]
        ),
        Question(
            text: "Which of these activities do you enjoy most? (Choose all that apply)",
            type: .multiple,
            answers: [
                Answer(text: "Refactoring legacy code", type: CodingStyle.architect),
                Answer(text: "Building quick prototypes", type: CodingStyle.hacker),
                Answer(text: "Writing comprehensive unit tests", type: CodingStyle.perfectionist),
                Answer(text: "Shipping features that users love", type: CodingStyle.pragmatist)
            ]
        ),
        Question(
            text: "A bug appears in production. What do you do?",
            type: .single,
            answers: [
                Answer(text: "Analyze the root cause and fix the underlying design flaw", type: CodingStyle.architect),
                Answer(text: "Quick hotfix now, proper solution later", type: CodingStyle.hacker),
                Answer(text: "Write a test that reproduces the bug, then fix it properly", type: CodingStyle.perfectionist),
                Answer(text: "Fix it in the simplest way that prevents it from happening again", type: CodingStyle.pragmatist)
            ]
        ),
        Question(
            text: "How important is code formatting to you?",
            type: .ranged,
            answers: [
                Answer(text: "Not important", type: CodingStyle.hacker),
                Answer(text: "Somewhat important", type: CodingStyle.pragmatist),
                Answer(text: "Very important", type: CodingStyle.architect),
                Answer(text: "Critical", type: CodingStyle.perfectionist)
            ]
        ),
        Question(
            text: "What's your attitude toward deadlines?",
            type: .single,
            answers: [
                Answer(text: "Plan carefully to deliver quality work on time", type: CodingStyle.architect),
                Answer(text: "Work intensely to ship whatever works by the deadline", type: CodingStyle.hacker),
                Answer(text: "Push back if quality would be compromised", type: CodingStyle.perfectionist),
                Answer(text: "Balance scope and quality to meet the deadline", type: CodingStyle.pragmatist)
            ]
        )
    ]
    
    // MARK: - Animal Personality Questions (Stretch Goal 1)
    static let animalQuestions: [Question] = [
        Question(
            text: "How do you prefer to spend your free time?",
            type: .single,
            answers: [
                Answer(text: "Playing sports or being active with friends", type: AnimalType.dog),
                Answer(text: "Relaxing alone with a good book or hobby", type: AnimalType.cat),
                Answer(text: "Planning my next big adventure or project", type: AnimalType.eagle),
                Answer(text: "Hanging out and chatting with a group", type: AnimalType.dolphin)
            ]
        ),
        Question(
            text: "When working on a team project, you typically:",
            type: .single,
            answers: [
                Answer(text: "Jump in enthusiastically and help wherever needed", type: AnimalType.dog),
                Answer(text: "Prefer to work on your assigned part independently", type: AnimalType.cat),
                Answer(text: "Take a leadership role and coordinate the big picture", type: AnimalType.eagle),
                Answer(text: "Focus on keeping everyone connected and motivated", type: AnimalType.dolphin)
            ]
        ),
        Question(
            text: "Which qualities describe you? (Choose all that apply)",
            type: .multiple,
            answers: [
                Answer(text: "Loyal and dependable", type: AnimalType.dog),
                Answer(text: "Independent and curious", type: AnimalType.cat),
                Answer(text: "Strategic and ambitious", type: AnimalType.eagle),
                Answer(text: "Empathetic and communicative", type: AnimalType.dolphin)
            ]
        ),
        Question(
            text: "Your ideal vacation would be:",
            type: .single,
            answers: [
                Answer(text: "Adventure trip with close friends", type: AnimalType.dog),
                Answer(text: "Solo retreat to somewhere peaceful", type: AnimalType.cat),
                Answer(text: "Expedition to explore a new culture or challenge", type: AnimalType.eagle),
                Answer(text: "Beach resort with lots of social activities", type: AnimalType.dolphin)
            ]
        ),
        Question(
            text: "How social are you?",
            type: .ranged,
            answers: [
                Answer(text: "Very independent", type: AnimalType.cat),
                Answer(text: "Balanced", type: AnimalType.eagle),
                Answer(text: "Pretty social", type: AnimalType.dog),
                Answer(text: "Extremely social", type: AnimalType.dolphin)
            ]
        ),
        Question(
            text: "When facing a challenge, you:",
            type: .single,
            answers: [
                Answer(text: "Rally your team and tackle it together", type: AnimalType.dog),
                Answer(text: "Figure it out on your own first", type: AnimalType.cat),
                Answer(text: "Step back and develop a strategic approach", type: AnimalType.eagle),
                Answer(text: "Discuss it with others to find the best solution", type: AnimalType.dolphin)
            ]
        )
    ]
    
    // MARK: - Career Path Questions (Stretch Goal 1)
    static let careerQuestions: [Question] = [
        Question(
            text: "What motivates you most at work?",
            type: .single,
            answers: [
                Answer(text: "Creating something unique and innovative", type: CareerType.creative),
                Answer(text: "Solving complex problems with data and logic", type: CareerType.analyst),
                Answer(text: "Leading teams and driving results", type: CareerType.leader),
                Answer(text: "Making a positive impact on people's lives", type: CareerType.helper)
            ]
        ),
        Question(
            text: "Your ideal work environment is:",
            type: .single,
            answers: [
                Answer(text: "Flexible and inspiring, with room for creativity", type: CareerType.creative),
                Answer(text: "Structured and focused, with clear objectives", type: CareerType.analyst),
                Answer(text: "Dynamic and fast-paced, with lots of responsibility", type: CareerType.leader),
                Answer(text: "Collaborative and supportive, making a difference", type: CareerType.helper)
            ]
        ),
        Question(
            text: "Which skills do you value most? (Choose all that apply)",
            type: .multiple,
            answers: [
                Answer(text: "Innovation and artistic expression", type: CareerType.creative),
                Answer(text: "Analytical thinking and attention to detail", type: CareerType.analyst),
                Answer(text: "Strategic planning and decision making", type: CareerType.leader),
                Answer(text: "Empathy and communication", type: CareerType.helper)
            ]
        ),
        Question(
            text: "In meetings, you typically:",
            type: .single,
            answers: [
                Answer(text: "Suggest creative solutions and new ideas", type: CareerType.creative),
                Answer(text: "Present data and analyze different options", type: CareerType.analyst),
                Answer(text: "Guide the discussion and make decisions", type: CareerType.leader),
                Answer(text: "Listen carefully and help build consensus", type: CareerType.helper)
            ]
        ),
        Question(
            text: "How important is work-life balance vs. career advancement?",
            type: .ranged,
            answers: [
                Answer(text: "Balance is key", type: CareerType.creative),
                Answer(text: "Moderate balance", type: CareerType.helper),
                Answer(text: "Career focused", type: CareerType.analyst),
                Answer(text: "Advancement driven", type: CareerType.leader)
            ]
        ),
        Question(
            text: "What type of tasks energize you?",
            type: .single,
            answers: [
                Answer(text: "Designing, creating, and brainstorming", type: CareerType.creative),
                Answer(text: "Researching, analyzing, and optimizing", type: CareerType.analyst),
                Answer(text: "Organizing, delegating, and strategizing", type: CareerType.leader),
                Answer(text: "Teaching, supporting, and collaborating", type: CareerType.helper)
            ]
        )
    ]
    
    // MARK: - Helper Method
    static func questions(for quizType: QuizType) -> [Question] {
        switch quizType {
        case .codingStyle:
            return codingStyleQuestions
        case .animalPersonality:
            return animalQuestions
        case .careerPath:
            return careerQuestions
        }
    }
}
