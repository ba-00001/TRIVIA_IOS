import UIKit

struct TriviaQuestion {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
}

class ViewController: UIViewController {

    @IBOutlet weak var question_number: UILabel!
    @IBOutlet weak var question_category: UILabel!
    @IBOutlet weak var question_prompt: UILabel!
    @IBOutlet weak var answer_1: UIButton!
    @IBOutlet weak var answer_2: UIButton!
    @IBOutlet weak var answer_3: UIButton!
    @IBOutlet weak var answer_4: UIButton!

    var currentQuestionIndex = 0
    var correctAnswersCount = 0
    var questions: [TriviaQuestion] = [
        TriviaQuestion(question: "What is the capital of France?", answers: ["Berlin", "Madrid", "Paris", "Rome"], correctAnswerIndex: 2),
        TriviaQuestion(question: "Which planet is known as the Red Planet?", answers: ["Mars", "Venus", "Jupiter", "Saturn"], correctAnswerIndex: 0),
        TriviaQuestion(question: "Who wrote 'Romeo and Juliet'?", answers: ["Charles Dickens", "William Shakespeare", "Jane Austen", "Leo Tolstoy"], correctAnswerIndex: 1),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }

    func showQuestion() {
        guard let currentQuestion = questions[safe: currentQuestionIndex] else {
            print("Current question is nil")
            return
        }

        // Update labels with question data
        question_prompt.text = currentQuestion.question
        question_number.text = "Question \(currentQuestionIndex + 1) of \(questions.count)"
        question_category.text = "General Knowledge"  // Change this based on your categories

        // Update button titles
        answer_1.setTitle(currentQuestion.answers[safe: 0], for: .normal)
        answer_2.setTitle(currentQuestion.answers[safe: 1], for: .normal)
        answer_3.setTitle(currentQuestion.answers[safe: 2], for: .normal)
        answer_4.setTitle(currentQuestion.answers[safe: 3], for: .normal)

        // Reset button colors
        answer_1.backgroundColor = UIColor.systemBlue
        answer_2.backgroundColor = UIColor.systemBlue
        answer_3.backgroundColor = UIColor.systemBlue
        answer_4.backgroundColor = UIColor.systemBlue
    }

    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let currentQuestion = questions[safe: currentQuestionIndex] else {
            print("Current question is nil")
            return
        }

        if sender.tag == currentQuestion.correctAnswerIndex {
            // Handle correct answer
            sender.backgroundColor = UIColor.green
            correctAnswersCount += 1
        } else {
            // Handle incorrect answer
            sender.backgroundColor = UIColor.red
        }

        // Move to the next question after a brief delay (you can customize this)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.moveToNextQuestion()
        }
    }

    func moveToNextQuestion() {
        currentQuestionIndex += 1

        if currentQuestionIndex < questions.count {
            // Show the next question
            showQuestion()
        } else {
            // Display final score or other completion logic
            showGameOverAlert()
        }
    }

    func resetGame() {
        currentQuestionIndex = 0
        correctAnswersCount = 0
        // Reset any other game-related variables or UI elements
        // Implement additional logic for restarting the game
        showQuestion()  // Optionally, show the first question immediately after resetting
    }

    func showGameOverAlert() {
        let alertController = UIAlertController(title: "Game Over", message: "Score: \(correctAnswersCount) / \(questions.count)", preferredStyle: .alert)

        let restartAction = UIAlertAction(title: "Restart", style: .default) { _ in
            // Handle restart logic
            self.resetGame()
        }

        alertController.addAction(restartAction)

        present(alertController, animated: true, completion: nil)
    }

}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
