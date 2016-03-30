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
    
    static var ISO8601formatter: NSDateFormatter {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return formatter
    }
    static var ISO8601UTCformatter: NSDateFormatter {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(abbreviation: "UTC")
        return formatter
    }
    static var DefaultTimeFormatter: NSDateFormatter {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }
    
    func dateFromISO8601String(string: String) -> NSDate? {
        return NSDate.ISO8601formatter.dateFromString(string)
    }
    
    func ISO8601String() -> String? {
        return NSDate.ISO8601formatter.stringFromDate(self)
    }
    
    func ISO8601StringUTC() -> String? {
        return NSDate.ISO8601UTCformatter.stringFromDate(self)
    }
    
    func defaultTimeString() -> String? {
        return NSDate.DefaultTimeFormatter.stringFromDate(self)
    }
    
    // MARK: -- components
    
    func hourOfDay() -> Int {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Hour], fromDate: self)
        return comp.hour
    }
    
    // zero-based value, Sunday = 0, Saturday = 6
    func dayOfWeek() -> Int {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Weekday], fromDate: self)
        return comp.weekday - 1
    }
    
    func isWeekday() -> Bool {
        let dayOfWeek = self.dayOfWeek()
        return dayOfWeek > 0 && dayOfWeek < 6
    }
    
    
    // MARK: -- calculators
    
    func daysAgo(days: Int) -> NSDate? {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Day, .Month, .Year, .Hour, .Minute, .Second, .Nanosecond], fromDate: self)
        comp.day = comp.day - days
        return cal.dateFromComponents(comp)
    }
    
    func yesterday() -> NSDate? {
        return daysAgo(1)
    }
    
    func tomorrow() -> NSDate? {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Day, .Month, .Year, .Hour, .Minute, .Second, .Nanosecond], fromDate: self)
        comp.day = comp.day + 1
        return cal.dateFromComponents(comp)
    }
    
    func oneWeekAgo() -> NSDate? {
        return daysAgo(7)
    }

    func oneYearAgo() -> NSDate? {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Day, .Month, .Year, .Hour, .Minute, .Second, .Nanosecond], fromDate: self)
        comp.year = comp.year - 1
        return cal.dateFromComponents(comp)
    }
    
    func todayAtHour(hour: Int) -> NSDate? {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Day, .Month, .Year], fromDate: self)
        comp.hour = hour
        return cal.dateFromComponents(comp)
    }

    /** Returns an NSDate at 00:00:00 on the date. */
    func startOfDay() -> NSDate? {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Day, .Month, .Year], fromDate: self)
        return cal.dateFromComponents(comp)
    }
    
    /** Returns an NSDate at 23:59:59 on the date. */
    func endOfDay() -> NSDate? {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Day, .Month, .Year], fromDate: self)
        comp.hour = 23
        comp.minute = 59
        comp.second = 59
        return cal.dateFromComponents(comp)
    }
    
    /** Returns an NSDate at the start of the hour (eg, 12:22:03 becomes 12:00:00.) */
    func startOfHour() -> NSDate? {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Day, .Month, .Year, .Hour], fromDate: self)
        return cal.dateFromComponents(comp)
    }

    /** Returns an NSDate at the start of the next hour (eg, 12:22:03 becomes 13:00:00.) */
    func startOfNextHour() -> NSDate? {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Day, .Month, .Year, .Hour], fromDate: self)
        comp.hour = comp.hour + 1
        return cal.dateFromComponents(comp)
    }
    
    /** Returns an NSDate at the end of the hour (eg, 12:22:03 becomes 12:59:59.) */
    func endOfHour() -> NSDate? {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Day, .Month, .Year, .Hour], fromDate: self)
        comp.minute = 59
        comp.second = 59
        return cal.dateFromComponents(comp)
    }

    /** Returns an NSDate at the end of the previous hour (eg, 12:22:03 becomes 11:59:59.) */
    func endOfPreviousHour() -> NSDate? {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components([.Day, .Month, .Year, .Hour], fromDate: self)
        comp.hour = comp.hour - 1
        comp.minute = 59
        comp.second = 59
        return cal.dateFromComponents(comp)
    }

    // MARK: -- comparitors
    
    func isInTheFuture() -> Bool {
        return self.timeIntervalSinceNow > 0
    }
    
    func isInThePast() -> Bool {
        return self.timeIntervalSinceNow < 0
    }
    
    func isEarlierThan(other: NSDate) -> Bool {
        return (self.compare(other) == NSComparisonResult.OrderedAscending)
    }
    
    func isLaterThan(other: NSDate) -> Bool {
        return (self.compare(other) == NSComparisonResult.OrderedDescending)
    }
    
    func isEqualTo(other: NSDate) -> Bool {
        return (self.compare(other) == NSComparisonResult.OrderedSame)
    }
    
    
    
}
