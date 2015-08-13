//
//  Mashable.swift
//  mashableReader
//
//  Created by Russell Schmidt on 8/12/15.
//  Copyright (c) 2015 RussellSchmidt.net. All rights reserved.
//

import UIKit
import Foundation

class MashableArticle {

  var title: String?
  var blurb: String?
  var content: NSDictionary?
  var articleText: String?


  init(jsonObjectDictionary: NSDictionary) {
    self.title = jsonObjectDictionary["title"] as? String
    self.blurb = jsonObjectDictionary["excerpt"] as? String

    self.content = jsonObjectDictionary["content"] as? NSDictionary
    //self.articleText = content["plain"] as? String
    // note that "plain" is a dictionary entry in dictionary Story
  }
}