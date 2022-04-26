import UIKit
import SnapKit

class PostViewController: UIViewController {

    var firstPost: String?


    private lazy var nextViewButton: UIButton = {
        let nextViewButton = UIButton(type: .system)
        nextViewButton.backgroundColor = .darkGray
        nextViewButton.setTitle("Дальше", for: .normal)
        nextViewButton.layer.cornerRadius = 10.0
        nextViewButton.addTarget(self, action: #selector(openNextController(_:)), for: .touchUpInside)
        return nextViewButton
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.backgroundColor = .systemCyan
        nameLabel.textColor = .white
        nameLabel.layer.cornerRadius = 10.0
        nameLabel.layer.borderColor = UIColor.white.cgColor
        nameLabel.layer.borderWidth = 1.5
        nameLabel.clipsToBounds = true
        return nameLabel
    }()

    private func configureLabel(text: String) {
        nameLabel.text = text
    }

    private var output: ViewOutput

    init(output: ViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        self.title = firstPost
        view.addSubviews(nameLabel, nextViewButton)

        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120.0)
            make.height.equalTo(50.0)
            make.width.greaterThanOrEqualTo(100.0)
        }

        nextViewButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(50.0)
            make.centerX.equalToSuperview()
            make.height.equalTo(50.0)
            make.width.equalTo(100.0)
        }
        
        navigationController?.isNavigationBarHidden = false

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(openInfoVC))
    }
    
    @objc func openNextController(_ sender: UIButton) {
        output.onSelectViewOutput?(.next)
    }
    
    @objc func openInfoVC(sender: UIBarButtonItem) {
        let modalInfoVC = InfoViewController()
        present(modalInfoVC, animated: true, completion: nil)
    }
}

extension PostViewController: ViewInput {
    func configure(text: String) {
        configureLabel(text: text)
    }


}
