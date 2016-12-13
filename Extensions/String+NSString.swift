//
//  String+NSString.swift
//  ORKSample
//
//  Created by Mike Revoir on 2/12/16.
//  Copyright © 2016 Apple, Inc. All rights reserved.
//

import Foundation

extension String {
    var ns: NSString {
        return self as NSString
    }
    var pathExtension: String? {
        return ns.pathExtension
    }
    var lastPathComponent: String? {
        return ns.lastPathComponent
    }
    var stringByDeletingLastPathComponent: String? {
        return ns.deletingLastPathComponent
    }
    func stringByAppendingPathComponent(_ path: String) -> String {
        return ns.appendingPathComponent(path)
    }
    var stringByDeletingPathExtension: String? {
        return ns.deletingPathExtension
    }
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
