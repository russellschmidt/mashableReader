//
//  ViewController.swift
//  mashableReader
//
//  Created by Russell Schmidt on 8/12/15.
//  Copyright (c) 2015 RussellSchmidt.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

  var mashableStories = [MashableArticle]()

  @IBOutlet var myTableView: UITableView!


  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    // we want JSON
    // instantiate a session
    let session = NSURLSession.sharedSession()

    // create the equivalent of a query string
    let url = NSURL(string: "http://mashable.com//stories.json")! // note the bang

    // query to be submitted
    let request = NSURLRequest(URL: url)

    let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in

      // incoming data is all binary that we need to convert to a string

      let str = NSString(data: data, encoding: NSUTF8StringEncoding)

      if error != nil {
        let d = error.localizedDescription
        println("ERR \(d)")
      } else {
        let jsonAllStories = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil) as! NSDictionary
        let jsonNewStories = jsonAllStories["new"] as! [NSDictionary]
        // OK so jsonNewStories is an array where each index is a dictionary that represents parts of an article title etc
        // there are also jsonAllStories ["rising", "hot"] in the array in the JSON output

        // now we loop through this array of stories
        for article in jsonNewStories {
          // we create a MashableArticle Object that does a lookup on the dictionary you pass it to pull out what it needs
          var mashableArticle = MashableArticle(jsonObjectDictionary: article)
          // we append this new MashableArticle Object to our main array we want to loop through
          self.mashableStories.append(mashableArticle)
        }
      }
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.myTableView.reloadData()
      })
      
    })
    task.resume()


  }

  // need this to reload the data after we dismiss ArticleViewController
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.myTableView.reloadData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  /*
  // To create a table view 
  // 1) decide on sections to show
  // 2) decide how many rows to draw
  // 3) populate the rows
  // 4) be able to select rows (optional)
  // 5) Add table view to storyboard
  // 6) Add table view cell to storyboard - 
  // 6.1) set Cell type (Utilities > Attributes Inspector>Style)
  // 6.5) table view cell name (Utilities > Attributes Inspector>Identifier)
  // 7) control-drag table view in storyboard to your View Controller to add as both data source and delegate
  // 8) add the delegate language to your ViewController.swift class definition (UITableViewDataSource, UITableViewDelegate)
  // 8.01) this is just adding ", UITableViewDataSource, UITableViewDelegate" without the quotes to the class name 
  // 8.02) after ViewController: UIViewController
  
  // things to remember
  // "mashableTableCell" --> prototype cell identifier

  */


  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return mashableStories.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("mashableTableCell", forIndexPath: indexPath) as! UITableViewCell
    cell.textLabel?.text = mashableStories[indexPath.row].title!
    cell.detailTextLabel?.text = mashableStories[indexPath.row].blurb
    return cell
  }

  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    let data = mashableStories[indexPath.row]
    self.performSegueWithIdentifier("articleSegue", sender: data)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "articleSegue" {
      if let selectedRowIndex = myTableView.indexPathForSelectedRow() {
        // instantiate the ViewController
        let articleVC = segue.destinationViewController as! ArticleViewController
        // set the destination viewcontroller object to the info we are passing
        articleVC.articleDetail = mashableStories[selectedRowIndex.row]
      }
    }
  }

}