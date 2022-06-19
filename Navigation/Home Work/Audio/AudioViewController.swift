//
//  ViewController.swift
//  AVFoundation_Audio
//
//  Created by Niki Pavlove on 18.02.2021.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {

    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.0
        progressView.tintColor = .black
        progressView.toAutoLayout()
        return progressView
    }()

    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .done, target: self, action: #selector(back))
        leftBarButtonItem.tintColor = .black
        return leftBarButtonItem
    }()
    
    // штатный AudioPlayer
    private var player: AVAudioPlayer = {
        let player = AVAudioPlayer()
        return player

    }()
    
    private lazy var buttonMenuView: UIView = {
        let buttonMenuView = UIView()
        buttonMenuView.toAutoLayout()
        buttonMenuView.layer.cornerRadius = 20.0
        buttonMenuView.layer.borderWidth = 1.0
        buttonMenuView.layer.borderColor = UIColor.black.cgColor

        return buttonMenuView
    }()

    private lazy var plusVolumeButton: UIButton = {
        let plusVolumeButton = UIButton(type: .system)
        plusVolumeButton.toAutoLayout()
        plusVolumeButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusVolumeButton.tintColor = .black
        plusVolumeButton.addTarget(self, action: #selector(volumeUp), for: .touchUpInside)
        return plusVolumeButton
    }()

    private lazy var minusVolumeButton: UIButton = {
        let minusVolumeButton = UIButton(type: .system)
        minusVolumeButton.toAutoLayout()
        minusVolumeButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minusVolumeButton.tintColor = .black
        minusVolumeButton.addTarget(self, action: #selector(volumeDown), for: .touchUpInside)

        return minusVolumeButton
    }()

    private lazy var playButton: UIButton = {
        let playButton = UIButton(type: .system)
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.tintColor = .black
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        playButton.toAutoLayout()
        return playButton
    }()

    private lazy var pauseButton: UIButton = {
        let pauseButton = UIButton(type: .system)
        pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        pauseButton.tintColor = .black
        pauseButton.addTarget(self, action: #selector(pause), for: .touchUpInside)
        pauseButton.toAutoLayout()
        return pauseButton
    }()

    private lazy var stopButton: UIButton = {
        let stopButton = UIButton(type: .system)
        stopButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        stopButton.tintColor = .black
        stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
        stopButton.toAutoLayout()
        return stopButton
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = ""
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.toAutoLayout()
        return nameLabel
    }()

    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .system)
        backButton.tintColor = .black
        backButton.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        backButton.toAutoLayout()
        backButton.addTarget(self, action: #selector(backTrack), for: .touchUpInside)
        return backButton
    }()

    private lazy var forwardButton: UIButton = {
        let forwardButton = UIButton(type: .system)
        forwardButton.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        forwardButton.tintColor = .black
        forwardButton.addTarget(self, action: #selector(forwardTrack), for: .touchUpInside)
        forwardButton.toAutoLayout()
        return forwardButton
    }()

    private var arrayOfTracks: [AudioTrack] = []
    private var currentTrack: CurrentTrack?


//    MARK: Properties
    private func addTracksToArray() {
        let Queen = AudioTrack(name: "Queen", type: .mp3)
        let Enigma = AudioTrack(name: "Enigma", type: .mp3)
        let jump = AudioTrack(name: "jump", type: .wav)
        let Royksopp = AudioTrack(name: "Royksopp feat. Susanne Sundfor - Never Ever", type: .mp3)
        let Muslim = AudioTrack(name: "Муслим Магомаев - Верни мне музыку", type: .mp3)

        arrayOfTracks.append(Queen)
        arrayOfTracks.append(Enigma)
        arrayOfTracks.append(Royksopp)
        arrayOfTracks.append(Muslim)
        arrayOfTracks.append(jump)
    }

    private func setNameToNameLabel() {
        nameLabel.text = currentTrack?.name
    }

    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = leftBarButtonItem
        title = "Audio"
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarItem = UITabBarItem(title: "Audio", image: UIImage(systemName: "music.note"), tag: 0)
        view.addSubviews(progressView, nameLabel, buttonMenuView, plusVolumeButton, minusVolumeButton)
        buttonMenuView.addSubviews(playButton, stopButton, pauseButton, backButton, forwardButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200.0),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10.0),

            progressView.widthAnchor.constraint(equalToConstant: 250.0),
            progressView.heightAnchor.constraint(equalToConstant: 2.0),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 300.0),

            plusVolumeButton.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            plusVolumeButton.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -50.0),

            minusVolumeButton.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            minusVolumeButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50.0),

            buttonMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            buttonMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            buttonMenuView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonMenuView.heightAnchor.constraint(equalToConstant: 50.0),
            buttonMenuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),

            pauseButton.widthAnchor.constraint(equalToConstant: 50.0),
            pauseButton.heightAnchor.constraint(equalToConstant: 50.0),
            pauseButton.centerXAnchor.constraint(equalTo: buttonMenuView.centerXAnchor),

            playButton.trailingAnchor.constraint(equalTo: pauseButton.leadingAnchor, constant: -30.0),
            playButton.widthAnchor.constraint(equalToConstant: 50.0),
            playButton.heightAnchor.constraint(equalToConstant: 50.0),

            stopButton.leadingAnchor.constraint(equalTo: pauseButton.trailingAnchor, constant: 30.0),
            stopButton.widthAnchor.constraint(equalToConstant: 50.0),
            stopButton.heightAnchor.constraint(equalToConstant: 50.0),

            backButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -30.0),
            backButton.widthAnchor.constraint(equalToConstant: 50.0),
            backButton.heightAnchor.constraint(equalToConstant: 50.0),

            forwardButton.leadingAnchor.constraint(equalTo: stopButton.trailingAnchor, constant: 30.0),
            forwardButton.widthAnchor.constraint(equalToConstant: 50.0),
            forwardButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }

    private func configurePlayer() {
        // конфигурирование аудиосессии - вывода звука на системное устройство (наушники или динамик)
        try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try! AVAudioSession.sharedInstance().setActive(true)

        let firstIndex = 0
        currentTrack = CurrentTrack(currentIndex: firstIndex, name: arrayOfTracks[firstIndex].name, type: arrayOfTracks[firstIndex].type)
        player.volume = 0.8
        player.prepareToPlay()
        preparePlay()
    }

    private func preparePlay() {
        // контент для проигрывания
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: currentTrack?.name, ofType: currentTrack?.type.rawValue)!)

        // подсказка для CoreAudio: формат мультимедиа-файла
        switch currentTrack?.type {
        case .mp3:
            player = try! AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        case .wav:
            player = try! AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        case .none:
            break
        }
        setNameToNameLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        addTracksToArray()
        setupUI()
        setupConstraints()
        configurePlayer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }

    @objc private func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @objc private func volumeUp(_ sender: UIButton) {
        if player.volume < 1 {
            player.volume += 0.1
        } else {
            print("Max Volume")
        }

    }

    @objc private func volumeDown(_ sender: UIButton) {
        if player.volume > 0 {
            player.volume -= 0.1
        } else {
            print("Min Volume")
        }
    }

    @objc private func play(_ sender: UIButton) {
        player.play()
        createTimer()
    }


    private var timer: Timer?
    private func createTimer() {
        if timer == nil {
            DispatchQueue.global().async {
                let timer = Timer(timeInterval: 0.1,
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

    @objc private func workForTimer() {
        DispatchQueue.main.async {
            let currentTime = self.player.currentTime / self.player.duration
            self.progressView.progress = Float(currentTime)
        }
    }

    @objc private func pause(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
        } else {
            print("Already stopped!")
        }
    }

    @objc private func stop(_ sender: UIButton) {
        player.stop()
        player.currentTime = 0.0
    }

    @objc private func forwardTrack() {
        if player.isPlaying {
            nextTrack()
            player.play()
        } else {
            nextTrack()
        }
    }

    @objc private func backTrack() {
        if player.isPlaying {
            previousTrack()
            player.play()
        } else {
            previousTrack()
        }
    }

    private func nextTrack() {
        player.stop()
        guard let index = currentTrack?.currentIndex else { return }
        if index + 1 >= arrayOfTracks.count {
            currentTrack?.currentIndex = 0
            currentTrack?.name = arrayOfTracks[currentTrack?.currentIndex ?? 0].name
            currentTrack?.type = arrayOfTracks[currentTrack?.currentIndex ?? 0].type
            preparePlay()
        } else {
            currentTrack?.currentIndex += 1
            currentTrack?.name = arrayOfTracks[currentTrack?.currentIndex ?? 0].name
            currentTrack?.type = arrayOfTracks[currentTrack?.currentIndex ?? 0].type
            preparePlay()
        }
    }

    private func previousTrack() {
        player.stop()
        guard let index = currentTrack?.currentIndex else { return }
        if index - 1 < 0 {
            currentTrack?.currentIndex = arrayOfTracks.count - 1
            currentTrack?.name = arrayOfTracks[currentTrack?.currentIndex ?? 0].name
            currentTrack?.type = arrayOfTracks[currentTrack?.currentIndex ?? 0].type
            preparePlay()
        } else {
            currentTrack?.currentIndex -= 1
            currentTrack?.name = arrayOfTracks[currentTrack?.currentIndex ?? 0].name
            currentTrack?.type = arrayOfTracks[currentTrack?.currentIndex ?? 0].type
            preparePlay()
        }
    }
}




//TODO: - Разобраться
extension AudioViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag == true {
            print("=====   Did finish playing   =====")
        }
    }
}
