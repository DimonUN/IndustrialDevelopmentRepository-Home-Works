//
//  Audio.swift
//  AVFoundation_Audio
//
//  Created by Дмитрий Никоноров on 17.06.2022.
//

import Foundation

class AudioTrack {
    enum FormatOfTrack: String {
        case mp3
        case wav
    }

    var name: String
    var type: FormatOfTrack
    lazy var url = URL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: type.rawValue) ?? "")

    init(name: String, type: FormatOfTrack) {
        self.name = name
        self.type = type
    }
}

class CurrentTrack: AudioTrack {
    var currentIndex: Int
    init(currentIndex: Int, name: String, type: FormatOfTrack) {
        self.currentIndex = currentIndex
        super.init(name: name, type: type)
    }
}
