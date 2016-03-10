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
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    func url() -> NSURL! {
        return NSURL(string:self)!
    }
}