//
//  GlobalConstant.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import Foundation
import UIKit


//MARK: - STORYBOARD
struct STORYBOARD {
    static var MAIN = UIStoryboard(name: "Main", bundle: nil)
}

//MARK:- DocumentDefaultValues
struct DocumentDefaultValues{
    struct Empty{
        static let string =  ""
        static let int =  0
        static let bool = false
        static let double = 0.0
    }
}

let VIDEO_ARRAY = ["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                   "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
                   "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
                   "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
                   "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"]

