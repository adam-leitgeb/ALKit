//
//  ErrorPlugin.swift
//  
//
//  Created by Adam Leitgeb on 12/03/2020.
//

import Foundation

public protocol ErrorPlugin: Plugin {
    var localizedDescription: String? { get set }
}
