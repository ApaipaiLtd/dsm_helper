//
//  SharingFile.swift
//  flutter_sharing_intent
//
//  Created by Bhagat on 29/11/22.
//

import Foundation

class SharingFile: Codable {
    var path: String;
    var thumbnail: String?; // video thumbnail
    var duration: Double?; // video duration in milliseconds
    var type: SharingFileType;


    init(path: String, thumbnail: String?, duration: Double?, type: SharingFileType) {
        self.path = path
        self.thumbnail = thumbnail
        self.duration = duration
        self.type = type
    }

    // toString method to print out SharingFile details in the console
    func toString() {
        print("[SharingFile] \n\tpath: \(self.path)\n\tthumbnail: \(self.thumbnail ?? "--" )\n\tduration: \(self.duration ?? 0)\n\ttype: \(self.type)")
    }

    func toData(data: [SharingFile]) -> Data {
        let encodedData = try? JSONEncoder().encode(data)
        return encodedData!
    }
}
