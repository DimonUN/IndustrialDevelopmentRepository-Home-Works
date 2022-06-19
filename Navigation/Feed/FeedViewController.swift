import UIKit

final class FeedViewController: UIViewController {
    private lazy var audionHomeWorkButton: UIButton = {
        let audionHomeWorkButton = UIButton(type: .system)
        audionHomeWorkButton.toAutoLayout()
        audionHomeWorkButton.setTitleColor(.white, for: .normal)
        audionHomeWorkButton.setTitle("Audio Home Work", for: .normal)
        audionHomeWorkButton.backgroundColor = .systemGreen
        audionHomeWorkButton.layer.cornerRadius = 20.0
        audionHomeWorkButton.addTarget(self, action: #selector(openFirstHomeWork), for: .touchUpInside)
        return audionHomeWorkButton
    }()

    private lazy var videoHomeWorkButton: UIButton = {
        let videoHomeWorkButton = UIButton(type: .system)
        videoHomeWorkButton.toAutoLayout()
        videoHomeWorkButton.setTitle("Video Home Work", for: .normal)
        videoHomeWorkButton.setTitleColor(.white, for: .normal)
        videoHomeWorkButton.backgroundColor = .systemBlue
        videoHomeWorkButton.layer.cornerRadius = 20.0
        videoHomeWorkButton.addTarget(self, action: #selector(openVideoHomeWork), for: .touchUpInside)
        return videoHomeWorkButton
    }()

    private lazy var recordingHomeWorkButton: UIButton = {
        let recordingHomeWorkButton = UIButton(type: .system)
        recordingHomeWorkButton.toAutoLayout()
        recordingHomeWorkButton.setTitle("Recording Home Work", for: .normal)
        recordingHomeWorkButton.setTitleColor(.white, for: .normal)
        recordingHomeWorkButton.backgroundColor = .systemPink
        recordingHomeWorkButton.layer.cornerRadius = 20.0
        recordingHomeWorkButton.addTarget(self, action: #selector(openRecordingHomeWork), for: .touchUpInside)
        return recordingHomeWorkButton
    }()

    @objc private func openRecordingHomeWork(_ sender: UIButton) {
        let recordingViewController = RecordViewController()
        let recordingNavigationController = UINavigationController(rootViewController: recordingViewController)
        recordingNavigationController.modalPresentationStyle = .fullScreen
        present(recordingNavigationController, animated: true)
    }

    @objc private func openFirstHomeWork(_ sender: UIButton) {
        let audioViewController = AudioViewController()
        let audioNavigationController = UINavigationController(rootViewController: audioViewController)
        audioNavigationController.modalPresentationStyle = .fullScreen
        present(audioNavigationController, animated: true)
    }

    @objc private func openVideoHomeWork(_ sender: UIButton) {
        let videoViewController = VideoViewController()
        let videonavigationController = UINavigationController(rootViewController: videoViewController)
        videonavigationController.modalPresentationStyle = .fullScreen
        present(videonavigationController, animated: true)
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Home Work"
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarItem = UITabBarItem(title: "Feed", image: .init(systemName: "house.fill"), tag: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.addSubviews(audionHomeWorkButton, videoHomeWorkButton, recordingHomeWorkButton)


        NSLayoutConstraint.activate([
            audionHomeWorkButton.widthAnchor.constraint(equalToConstant: 200.0),
            audionHomeWorkButton.heightAnchor.constraint(equalToConstant: 50.0),
            audionHomeWorkButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
            audionHomeWorkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            videoHomeWorkButton.widthAnchor.constraint(equalToConstant: 200.0),
            videoHomeWorkButton.heightAnchor.constraint(equalToConstant: 50.0),
            videoHomeWorkButton.topAnchor.constraint(equalTo: audionHomeWorkButton.bottomAnchor, constant: 20.0),
            videoHomeWorkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            recordingHomeWorkButton.widthAnchor.constraint(equalToConstant: 200.0),
            recordingHomeWorkButton.heightAnchor.constraint(equalToConstant: 50.0),
            recordingHomeWorkButton.topAnchor.constraint(equalTo: videoHomeWorkButton.bottomAnchor, constant: 20.0),
            recordingHomeWorkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])



    }


}
