//
//  Arbitary.swift
//  
//
//  Created by Adam Leitgeb on 22/02/2020.
//

import Foundation

public protocol Arbitary {
    static func arbitary() -> Self
    static func shortArbitary() -> Self
}

public extension Arbitary {
    static func shortArbitary() -> Self {
        arbitary()
    }
}

public extension Array where Element: Arbitary {
    static func arbitary() -> [Element] {
        (1...10).map { _ in Element.arbitary() }
    }

    static func shortArbitary() -> [Element] {
        (1...5).map { _ in Element.shortArbitary() }
    }
}

// MARK: - Foundation support

extension Int: Arbitary {
    public static func arbitary() -> Int {
        Int.random(in: 1...1_000)
    }
}

extension Double: Arbitary {
    public static func arbitary() -> Double {
        Double.random(in: 1.0...1_000.0)
    }
}

extension String: Arbitary {
    public static func arbitary() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz "
        return String((1...180).compactMap { _ in letters.randomElement() }).capitalized
    }

    public static func shortArbitary() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz "
        return String((1...10).compactMap { _ in letters.randomElement() }).capitalized
    }
}

extension Bool: Arbitary {
    public static func arbitary() -> Bool {
        Bool.random()
    }
}

extension Date: Arbitary {
    public static func arbitary() -> Date {
        let now = Date()
        let minDate = Calendar.current.date(byAdding: .day, value: -7, to: now) ?? Date()
        let randomTimeInterval = Double.random(in: minDate.timeIntervalSince1970...now.timeIntervalSince1970)

        return Date(timeIntervalSince1970: randomTimeInterval)
    }
}

extension URL: Arbitary {
    public static func arbitary() -> URL {
        [
            URL(string: "https://pbs.twimg.com/profile_images/527573306783059968/9G1ge-R8_400x400.jpeg"),
            URL(string: "https://translate.google.co.th/?hl=cs&tab=iT1&authuser=0"),
            URL(string: "https://cdn-static.denofgeek.com/sites/denofgeek/files/styles/main_wide/public/images/6422.jpg?itok=n5PS1pzN")
        ].compactMap{ $0 }.randomElement()!
    }
}
