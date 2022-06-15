import UIKit

final class FeedViewController: UIViewController {

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
            self.mainRegister += 1
            if self.counter == 0 {
                self.createColor()
            }
        }
    }

    @objc func buttonAction(sender: UIButton) {
        if timer == nil {
            invalidateButton.setTitle("Invalidate", for: .normal)
            createTimer()
            print("start timer")
        } else {
            timer?.invalidate()
            timer = nil
            invalidateButton.setTitle("Continue", for: .normal)
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
        invalidateButton.setTitle("Start", for: .normal)
        invalidateButton.setTitleColor(.white, for: .normal)
        invalidateButton.layer.cornerRadius = 20.0
        invalidateButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return invalidateButton
    }()


    //    MARK: - Home Work 2)
    private var mainRegister = 0
    private var timeFromStartRegistratoin = 0
    private var registrationTimer: Timer?

    enum RegistrationError: Error {
        case notRegistration
        case toLongTime
    }

    private lazy var startRegisterationButton: UIButton = {
        let startRegisterationButton = UIButton(type: .system)
        startRegisterationButton.toAutoLayout()
        startRegisterationButton.backgroundColor = .systemOrange
        startRegisterationButton.setTitle("Проверить счетчик", for: .normal)
        startRegisterationButton.addTarget(self, action: #selector(startRegistration(sender:)), for: .touchUpInside)
        startRegisterationButton.setTitleColor(.white, for: .normal)
        startRegisterationButton.layer.cornerRadius = 20.0
        return startRegisterationButton
    }()

    @objc private func startRegistration(sender: UIButton) {
        DispatchQueue.global().async {
            let registrationTimer = Timer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(self.registerForTimer),
                userInfo: nil,
                repeats: true
            )
            self.registrationTimer = registrationTimer
            RunLoop.current.add(registrationTimer, forMode: .common)
            RunLoop.current.run()
            registrationTimer.tolerance = 0.1
        }
    }

    private func register(completion: ((Result<Int, RegistrationError>) -> Void)?) {
        if timeFromStartRegistratoin == 3 {
            registrationTimer?.invalidate()
            timeFromStartRegistratoin = 0
            switch mainRegister {
            case 0..<10:
                completion?(.failure(.notRegistration))
            case 10...30:
                completion?(.success(mainRegister))
            case 31...100:
                completion?(.failure(.toLongTime))
            default:
                break
            }
        }
    }

    @objc private func registerForTimer() {
        timeFromStartRegistratoin += 1
        register { result in
            switch result {
            case let .success(value):
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Успешно после \(value) секунд", message: nil, preferredStyle: .actionSheet)
                    let okAction = UIAlertAction(title: "Ок" , style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }

            case .failure(.notRegistration):
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Не успешно, повторите позже", message: nil, preferredStyle: .actionSheet)
                    let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }

            case .failure(.toLongTime):
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Слишком долго ждал", message: nil, preferredStyle: .actionSheet)
                    let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                    alertController.addAction(okAction)

                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }





    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countdownLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            invalidateButton.heightAnchor.constraint(equalToConstant: 50),
            invalidateButton.widthAnchor.constraint(equalToConstant: 100),
            invalidateButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            invalidateButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

            startRegisterationButton.topAnchor.constraint(equalTo: invalidateButton.bottomAnchor, constant: 100.0),
            startRegisterationButton.centerXAnchor.constraint(equalTo: invalidateButton.centerXAnchor),
            startRegisterationButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Your feed"
        view.addSubviews(countdownLabel, invalidateButton, startRegisterationButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
//       Изначальный вариант предполагает, что таймер включается сам.
//        createTimer()
    }
}
