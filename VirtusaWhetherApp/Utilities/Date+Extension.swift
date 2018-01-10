//
//  Date+Extension.swift
//  VirtusaWhetherApp
//
//  Created by Surendra Singh on 1/8/18.
//  Copyright © 2018 Surendra Singh. All rights reserved.
//

import UIKit

extension Date {
    //Local formating 
    func currentTimeZoneDate() -> String {
        let dtf = DateFormatter()
        dtf.locale = Locale(identifier: "en_US_POSIX")
        dtf.dateStyle = .long
        dtf.dateFormat = "h:mm a"
        dtf.amSymbol = "AM"
        dtf.pmSymbol = "PM"
        return dtf.string(from: self)
    }
}
