//
//  ArticleViewController.swift
//  mashableReader
//
//  Created by Russell Schmidt on 8/13/15.
//  Copyright (c) 2015 RussellSchmidt.net. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

  @IBOutlet var headline: UILabel!
  @IBOutlet var subheadline: UILabel!
  @IBOutlet var article: UILabel!

  @IBOutlet var scrollViewOutlet: UIScrollView!
  
  // this is the variable we are going to pass our info into
  var articleDetail: MashableArticle?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.headline?.text = articleDetail?.title
        self.subheadline?.text = articleDetail?.blurb
        if let articleDict = articleDetail?.content {
          self.article?.text = articleDict["plain"] as? String
        } else {
          self.article?.text = "Doh"
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  @IBAction func swipeLeftToDismiss(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}
