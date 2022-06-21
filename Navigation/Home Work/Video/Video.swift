//
//  Video.swift
//  AVFoundation_Audio
//
//  Created by Дмитрий Никоноров on 17.06.2022.
//

import Foundation

class VideoProvider {
    static func get() -> [Video] {
        return [
            Video(remoteAdress: "https://www.youtube.com/watch?v=KWzlv6VNekg", name: "devstreaming"),
            Video(name: "video", format: .mp4),
            Video(name: "test", format: .mp4)
        ]
    }
}

class Video {
    enum FormatOfVideo: String {
        case mp4
    }

    let name: String?
    let format: FormatOfVideo?

    let remoteAdress: String?
    let url: URL

    init(name: String, format: FormatOfVideo) {
        self.name = name
        self.format = format
        self.url = URL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: format.rawValue)!)
        remoteAdress = nil
    }

    init(remoteAdress: String, name: String) {
        self.remoteAdress = remoteAdress
        self.url = URL(string: remoteAdress) ?? URL(string: "https://")!
        self.name = name
        self.format = .none
    }
}
