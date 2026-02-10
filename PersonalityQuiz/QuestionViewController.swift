//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Claude
//

import UIKit

class QuestionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var questionProgressLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    // Single answer outlets
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    // Multiple answer outlets
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multiLabels: [UILabel]!
    @IBOutlet var multiSwitches: [UISwitch]!
    
    // Ranged answer outlets
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionButton: UIButton!
    
    // MARK: - Properties
    var questions: [Question] = QuestionData.questions
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Methods
    func updateUI() {
        // Hide all answer views initially
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        
        // Update navigation and progress
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionProgressLabel.text = "Question \(questionIndex + 1) of \(questions.count)"
        questionLabel.text = currentQuestion.text
        
        // Show appropriate answer type
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        questionButton.isHidden = true
        
        for (index, button) in singleButtons.enumerated() {
            button.setTitle(answers[index].text, for: .normal)
            button.isHidden = false
        }
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        questionButton.setTitle("Submit Answer", for: .normal)
        questionButton.isHidden = false
        
        for (index, label) in multiLabels.enumerated() {
            label.text = answers[index].text
        }
        
        for switchControl in multiSwitches {
            switchControl.isOn = false
        }
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        questionButton.setTitle("Submit Answer", for: .normal)
        questionButton.isHidden = false
        
        rangedSlider.minimumValue = 0
        rangedSlider.maximumValue = Float(answers.count - 1)
        rangedSlider.value = Float(answers.count - 1) / 2
        
        rangedLabels[0].text = answers.first?.text
        rangedLabels[1].text = answers.last?.text
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    // MARK: - Actions
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        if let index = singleButtons.firstIndex(of: sender) {
            answersChosen.append(currentAnswers[index])
        }
        
        nextQuestion()
    }
    
    @IBAction func questionButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch questions[questionIndex].type {
        case .multiple:
            for (index, switchControl) in multiSwitches.enumerated() {
                if switchControl.isOn {
                    answersChosen.append(currentAnswers[index])
                }
            }
        case .ranged:
            let index = Int(round(rangedSlider.value))
            answersChosen.append(currentAnswers[index])
        default:
            break
        }
        
        nextQuestion()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
}
