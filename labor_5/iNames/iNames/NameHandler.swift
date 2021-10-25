//
//  NameHandler.swift
//  iNames
//
//  Created by Rakolcza Peter on 2021. 10. 23..
//

import Foundation

class NameHandler {

  let names: [AnyObject]?

  static let shared = NameHandler()

  private init() {
    let path = Bundle.main.path(forResource: "Names", ofType: "plist")
    names = NSArray(contentsOfFile: path!)! as [AnyObject]
  }

}

