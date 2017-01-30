//
//  NSDate+Utility.swift
//  apple
//
//  Created by Mike Revoir on 3/2/16.
//  Copyright © 2016 Duke Institute for Health Innovation. All rights reserved.
//

import Foundation

extension NSDate {
    
    // MARK: -- formatters
    
    static var ISO8601formatter: DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
    static var ISO8601UTCformatter: DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
    static var DefaultShortDateFormatter: DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }
    static var DefaultTimeFormatter: DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }
    
    func dateFromISO8601String(_ string: String) -> Date? {
        return Date.ISO8601formatter.date(from: string)
    }
    
    func ISO8601String() -> String? {
        return Date.ISO8601formatter.string(from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
    }
    
    func ISO8601StringUTC() -> String? {
        return Date.ISO8601UTCformatter.string(from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
    }
    
    func defaultTimeString() -> String? {
        return Date.DefaultTimeFormatter.string(from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
    }
    
    func defaultString() -> String? {
        return ISO8601String()
    }
    
    func shortDateString() -> String {
        return Date.DefaultShortDateFormatter.string(from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
    }
    
    // MARK: -- converters
    
    func gregorianCalendarComponentValue(_ unitFlags: NSCalendar.Unit) -> DateComponents {
        let gregorianCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let components: DateComponents = (gregorianCalendar as NSCalendar).components(unitFlags, from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        (components as NSDateComponents).calendar = gregorianCalendar
        return components
    }
    
    // MARK: -- components
    
    func hourOfDay() -> Int {
        let cal: Calendar = Calendar.current
        let comp: DateComponents = (cal as NSCalendar).components([.hour], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        return comp.hour!
    }
    
    // zero-based value, Sunday = 0, Saturday = 6
    func dayOfWeek() -> Int {
        let cal: Calendar = Calendar.current
        let comp: DateComponents = (cal as NSCalendar).components([.weekday], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        return comp.weekday! - 1
    }
    
    func dayOfYear() -> Int {
        let cal: Calendar = Calendar.current
        return (cal as NSCalendar).ordinality(of: .day, in: .year, for: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
    }
    
    func isWeekday() -> Bool {
        let dayOfWeek = self.dayOfWeek()
        return dayOfWeek > 0 && dayOfWeek < 6
    }
    
    
    // MARK: -- calculators
    
    func daysAgo(_ days: Int) -> Date? {
        let cal: Calendar = Calendar.current
        var comp: DateComponents = (cal as NSCalendar).components([.day, .month, .year, .hour, .minute, .second, .nanosecond], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        comp.day = comp.day! - days
        return cal.date(from: comp)
    }
    
    func yesterday() -> Date? {
        return daysAgo(1)
    }
    
    func tomorrow() -> Date? {
        let cal: Calendar = Calendar.current
        var comp: DateComponents = (cal as NSCalendar).components([.day, .month, .year, .hour, .minute, .second, .nanosecond], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        comp.day = comp.day! + 1
        return cal.date(from: comp)
    }
    
    func oneWeekAgo() -> Date? {
        return daysAgo(7)
    }
    
    func oneYearAgo() -> Date? {
        let cal: Calendar = Calendar.current
        var comp: DateComponents = (cal as NSCalendar).components([.day, .month, .year, .hour, .minute, .second, .nanosecond], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        comp.year = comp.year! - 1
        return cal.date(from: comp)
    }
    
    func todayAtHour(_ hour: Int) -> Date? {
        let cal: Calendar = Calendar.current
        var comp: DateComponents = (cal as NSCalendar).components([.day, .month, .year], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        comp.hour = hour
        return cal.date(from: comp)
    }
    
    /** Returns an NSDate at 00:00:00 on the date. */
    func startOfDay() -> Date? {
        let cal: Calendar = Calendar.current
        let comp: DateComponents = (cal as NSCalendar).components([.day, .month, .year], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        return cal.date(from: comp)
    }
    
    /** Returns an NSDate at 23:59:59 on the date. */
    func endOfDay() -> Date? {
        let cal: Calendar = Calendar.current
        var comp: DateComponents = (cal as NSCalendar).components([.day, .month, .year], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        comp.hour = 23
        comp.minute = 59
        comp.second = 59
        return cal.date(from: comp)
    }
    
    /** Returns an NSDate at the start of the hour (eg, 12:22:03 becomes 12:00:00.) */
    func startOfHour() -> Date? {
        let cal: Calendar = Calendar.current
        let comp: DateComponents = (cal as NSCalendar).components([.day, .month, .year, .hour], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        return cal.date(from: comp)
    }
    
    /** Returns an NSDate at the start of the next hour (eg, 12:22:03 becomes 13:00:00.) */
    func startOfNextHour() -> Date? {
        let cal: Calendar = Calendar.current
        var comp: DateComponents = (cal as NSCalendar).components([.day, .month, .year, .hour], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        comp.hour = comp.hour! + 1
        return cal.date(from: comp)
    }
    
    /** Returns an NSDate at the end of the hour (eg, 12:22:03 becomes 12:59:59.) */
    func endOfHour() -> Date? {
        let cal: Calendar = Calendar.current
        var comp: DateComponents = (cal as NSCalendar).components([.day, .month, .year, .hour], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        comp.minute = 59
        comp.second = 59
        return cal.date(from: comp)
    }
    
    /** Returns an NSDate at the end of the previous hour (eg, 12:22:03 becomes 11:59:59.) */
    func endOfPreviousHour() -> Date? {
        let cal: Calendar = Calendar.current
        var comp: DateComponents = (cal as NSCalendar).components([.day, .month, .year, .hour], from: Date(timeIntervalSinceReferenceDate:self.timeIntervalSinceNow))
        comp.hour = comp.hour! - 1
        comp.minute = 59
        comp.second = 59
        return cal.date(from: comp)
    }
    
    /** Returns the number of days since the other date. Days in the future have negative values. */
    func daysSince(_ other: Date) -> Int {
        let cal: Calendar = Calendar.current
        let comp: DateComponents = (cal as NSCalendar).components([.day], from: other.startOfDay()!, to: self.startOfDay()!, options: [.wrapComponents])
        return comp.day!
    }
    
    // MARK: -- comparitors
    
    func isInTheFuture() -> Bool {
        return self.timeIntervalSinceNow > 0
    }
    
    func isInThePast() -> Bool {
        return self.timeIntervalSinceNow < 0
    }
    
    func isEarlierThan(_ other: Date) -> Bool {
        return (self.compare(other) == ComparisonResult.orderedAscending)
    }
    
    func isLaterThan(_ other: Date) -> Bool {
        return (self.compare(other) == ComparisonResult.orderedDescending)
    }
    
    func isEqualTo(_ other: Date) -> Bool {
        return (self.compare(other) == ComparisonResult.orderedSame)
    }
        
}
