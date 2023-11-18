//
//  Extension+String.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

extension String {
    public static func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        let timeString = formatter.string(from: date)
        
        let isPM = Calendar.current.component(.hour, from: date) >= 12
        let amPmString = isPM ? "오후" : "오전"
        
        return amPmString 
    }
    
    public static func formattedTimeWithoutAmPm(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return formatter.string(from: date)
    }
    
    public static func formattedHourTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"  // "a" will add AM/PM to the time
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        return formatter.string(from: date)
    }



}
