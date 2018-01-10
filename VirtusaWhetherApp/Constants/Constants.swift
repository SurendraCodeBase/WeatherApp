//
//  Constants.swift
//  VirtusaWhetherApp
//
//  Created by Surendra Singh on 1/8/18.
//  Copyright © 2018 Surendra Singh. All rights reserved.
//

import UIKit

let APP_KEY = "2d50148274357e64b853236dea81a8b1"
let HOST_NAME = "http://api.openweathermap.org"
let DATA_BYNAME = HOST_NAME + "/data/2.5/weather"
let IMAGE_DOWNLOAD = "http://openweathermap.org/img/w/"


//Error messages
let NetworkNotAvailable = "Please check network availablity on your device. It seems that device is not connected to network."
let HostNotReachable = "Host [\(HOST_NAME)] is not available. Please contact responsible person. Or try later."


enum NetworkErrors:Error{
    case NetworkNotAvailable(message:String)
    case HostNotReachable(message:String)
}

let LAST_SEARCHED_TEXT = "LAST_SEARCHED_TEXT"
