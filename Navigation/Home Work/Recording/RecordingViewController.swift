//
//  RecordingViewController.swift
//  AVFoundation_Audio
//
//  Created by Дмитрий Никоноров on 17.06.2022.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {

    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .done, target: self, action: #selector(back))
        leftBarButtonItem.tintColor = .black
        return leftBarButtonItem
    }()

    private lazy var recordButton: UIButton = {
        let recordButton = UIButton(type: .system)
        recordButton.toAutoLayout()
        recordButton.setTitle("Record", for: .normal)
        recordButton.setTitleColor(UIColor.black, for: .normal)
        recordButton.layer.borderWidth = 1.0
        recordButton.layer.borderColor = UIColor.red.cgColor
        recordButton.backgroundColor = .systemRed
        recordButton.layer.cornerRadius = 20.0
        recordButton.addTarget(self, action: #selector(startRecord), for: .touchUpInside)
        return recordButton
    }()

    private lazy var playButton: UIButton = {
        let playButton = UIButton(type: .system)
        playButton.toAutoLayout()
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(UIColor.black, for: .normal)
        playButton.layer.borderWidth = 1.0
        playButton.layer.borderColor = UIColor.red.cgColor
        playButton.backgroundColor = .systemRed
        playButton.layer.cornerRadius = 20.0
        playButton.addTarget(self, action: #selector(playRecord), for: .touchUpInside)
        return playButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        playButton.isEnabled = false
        playButton.alpha = 0.6
        title = "Record"
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(recordButton)
        view.addSubview(playButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            recordButton.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            recordButton.widthAnchor.constraint(
                equalToConstant: 100.0
            ),
            recordButton.heightAnchor.constraint(
                equalToConstant: 100.0
            ),
            playButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            playButton.topAnchor.constraint(
                equalTo: recordButton.bottomAnchor,
                constant: 50.0
            ),
            playButton.widthAnchor.constraint(
                equalToConstant: 100.0
            ),
            playButton.heightAnchor.constraint(
                equalToConstant: 100.0
            )
        ])
    }

//    MARK: - RECORDING
    private var audioRecorder: AVAudioRecorder!
    private var audioPlayer: AVAudioPlayer!
    private var audioFile = "audio.m4a"
    private func getDocumentsDirector() -> URL {
        let paths = FileManager.default.urls(
            for: .documentDirectory,
               in: .userDomainMask
        )
        return paths[0]
    }

    private func setupRecorder() {
        let audioFilename = getDocumentsDirector().appendingPathComponent(audioFile)
        let recordSetting = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 1,
            AVSampleRateKey: 44100.2
        ] as [String: Any]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: recordSetting)
            audioRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }

    private func setupPlayer() {
        let audioFilename = getDocumentsDirector().appendingPathComponent(audioFile)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
        } catch {
            print(error)
        }
    }

    private func tooglePlayButton() {
        if playButton.isEnabled {
            playButton.alpha = 1.0
        } else {
            playButton.alpha = 0.6
        }
    }

    private func toogleRecordButton() {
        if recordButton.isEnabled {
            recordButton.alpha = 1.0
        } else {
            recordButton.alpha = 0.6
        }
    }

    @objc private func startRecord(_ sender: UIButton) {
        if recordButton.titleLabel?.text == "Record" {
            audioRecorder.record()
            recordButton.setTitle("Stop", for: .normal)
            playButton.isEnabled = false
            tooglePlayButton()
        } else {
            audioRecorder.stop()
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
            tooglePlayButton()
        }
    }

    @objc private func playRecord(_ sender: UIButton) {
        if playButton.titleLabel?.text == "Play" {
            playButton.setTitle("Stop", for: .normal)
            recordButton.isEnabled = false
            toogleRecordButton()
            setupPlayer()
            audioPlayer.play()
        } else {
            audioPlayer.stop()
            playButton.setTitle("Play", for: .normal)
            recordButton.isEnabled = true
            toogleRecordButton()
        }
    }

    @objc private func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}

extension RecordViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playButton.setTitle("Play", for: .normal)
        recordButton.isEnabled = true
        toogleRecordButton()
    }
}

