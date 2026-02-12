//
//  IntroductionViewController.swift
//  PersonalityQuiz
//
//  Updated with Stretch Goals 1 & 4 (Quiz Selection & History)
//

import UIKit

class IntroductionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var quizSegmentedControl: UISegmentedControl!
    @IBOutlet weak var quizTitleLabel: UILabel!
    @IBOutlet weak var quizSubtitleLabel: UILabel!
    
    // MARK: - Properties
    var selectedQuizType: QuizType = .codingStyle
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        updateQuizInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reset navigation bar when returning
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Setup
    func setupSegmentedControl() {
        // Clear existing segments
        quizSegmentedControl?.removeAllSegments()
        
        // Add segments for each quiz type
        for (index, quizType) in QuizType.allCases.enumerated() {
            let title: String
            switch quizType {
            case .codingStyle:
                title = "Coding"
            case .animalPersonality:
                title = "Animal"
            case .careerPath:
                title = "Career"
            }
            quizSegmentedControl?.insertSegment(withTitle: title, at: index, animated: false)
        }
        
        quizSegmentedControl?.selectedSegmentIndex = 0
    }
    
    func updateQuizInfo() {
        quizTitleLabel?.text = selectedQuizType.title
        quizSubtitleLabel?.text = selectedQuizType.subtitle
    }
    
    // MARK: - Actions
    @IBAction func quizTypeChanged(_ sender: UISegmentedControl) {
        selectedQuizType = QuizType.allCases[sender.selectedSegmentIndex]
            print("🔵 Quiz type changed to: \(selectedQuizType)")
            print("🔵 Selected index: \(sender.selectedSegmentIndex)")
            updateQuizInfo()
        }
    
    @IBAction func viewHistoryTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowHistory", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BeginQuiz" {
            print("🔵 Preparing segue BeginQuiz")
            print("🔵 Current selectedQuizType: \(selectedQuizType)")
            if let questionVC = segue.destination as? QuestionViewController {
                questionVC.selectedQuizType = selectedQuizType
                print("🔵 Passed quiz type to QuestionVC: \(selectedQuizType)")
            } else {
                print("🔴 ERROR: Could not cast to QuestionViewController")
            }
        }
    }
}
