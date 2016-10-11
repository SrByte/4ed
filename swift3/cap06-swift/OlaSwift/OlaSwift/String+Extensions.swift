//
//  String+Trim.swift
//  Carros
//
//  Created by Ricardo Lecheta on 6/29/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation

extension String {
    func trim() -> String {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString
    }
    func url() -> URL {
        return URL(string:self)!
    }
}
