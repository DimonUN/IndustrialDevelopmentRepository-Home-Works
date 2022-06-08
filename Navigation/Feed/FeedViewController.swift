import UIKit

final class FeedViewController: UIViewController {

    //    MARK: - Home Work
    private var timer: Timer?
    private func createTimer() {
        if timer == nil {
            DispatchQueue.global().async {
                let timer = Timer(timeInterval: 1.0,
                                  target: self,
                                  selector: #selector(self.workForTimer),
                                  userInfo: nil,
                                  repeats: true)
                self.timer = timer
                RunLoop.current.add(timer, forMode: .common)
                RunLoop.current.run()
                timer.tolerance = 0.1
            }
        }
    }

    private lazy var counter: Int = 3 {
        didSet {
            if oldValue == 0 {
                self.counter = 3
            }
            self.countdownLabel.text = "До обновления экрана осталось \(self.counter) сек"
        }
    }

    @objc private func workForTimer() {
        DispatchQueue.main.async {
            self.counter -= 1
            if self.counter == 0 {
                self.createColor()
            }
        }
    }

    @objc func buttonAction(sender: UIButton) {
        if timer == nil {
            createTimer()
            print("start timer")
        } else {
            timer?.invalidate()
            timer = nil
            print("invalidate")
        }
    }

    private func createColor() {
        let randomColor = UIColor.init(
            red: CGFloat(Int.random(in: 1..<255)) / 255.0,
            green: CGFloat(Int.random(in: 1..<255)) / 255.0,
            blue: CGFloat(Int.random(in: 1..<255)) / 255.0,
            alpha: 1.0
        )
        self.view.backgroundColor = randomColor
    }

    private lazy var countdownLabel: UILabel = {
        let countdownLabel = UILabel()
        countdownLabel.toAutoLayout()
        countdownLabel.backgroundColor = .yellow
        countdownLabel.text = "До обновления экрана осталось \(counter) сек"
        return countdownLabel
    }()

    private lazy var invalidateButton: UIButton = {
        let invalidateButton = UIButton(type: .system)
        invalidateButton.toAutoLayout()
        invalidateButton.backgroundColor = .systemBlue
        invalidateButton.setTitle("Invalidate", for: .normal)
        invalidateButton.setTitleColor(.white, for: .normal)
        invalidateButton.layer.cornerRadius = 20.0
        invalidateButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return invalidateButton
    }()

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countdownLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            invalidateButton.heightAnchor.constraint(equalToConstant: 50),
            invalidateButton.widthAnchor.constraint(equalToConstant: 100),
            invalidateButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            invalidateButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Your feed"
        view.addSubviews(countdownLabel, invalidateButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        createTimer()
    }
}
