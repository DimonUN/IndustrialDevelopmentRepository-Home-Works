//
//  VideoViewController.swift
//  AVFoundation_Audio
//
//  Created by Дмитрий Никоноров on 17.06.2022.
//

import Foundation
import UIKit
import AVKit

class VideoViewController: UIViewController {
    private enum CellReuseIdentifiers: String {
        case videos
    }

    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .done, target: self, action: #selector(back))
        leftBarButtonItem.tintColor = .black
        return leftBarButtonItem
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.toAutoLayout()
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .singleLine
        return tableView
    }()

    private lazy var arraOfVideos: [Video] = VideoProvider.get()

    private func setupTableView() {
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.videos.rawValue)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.rowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200.0

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = leftBarButtonItem
        title = "Video"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }

    @objc private func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension VideoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraOfVideos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.videos.rawValue, for: indexPath) as! VideoTableViewCell
        let data = arraOfVideos[indexPath.row]
        cell.update(name: data.name ?? "")

        return cell

    }
}

extension VideoViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Создаём AVPlayer со ссылкой на видео.
        let video = arraOfVideos[indexPath.row]
        let player = AVPlayer(url: video.url)

        // Создаём AVPlayerViewController и передаём ссылку на плеер.
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true

        present(controller, animated: true) {
            player.play()
        }
    }
}
