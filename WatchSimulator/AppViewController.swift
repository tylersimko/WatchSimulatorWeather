//
//  WatchAppViewController.swift
//  WatchSimulator
//
//  Simulator Created by temporary on 10/12/14.
//  Copyright (c) 2014 Ben Morrow. All rights reserved.
// test 3939393
// Weather App created by Tyler Simko on 10/27/14

import UIKit

class AppViewController: UIViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
private let apiKey = "3f60bce32cdff52c184189c2db6c0007"

override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tempLabel.text = "Hello!"
    getCurrentWeatherData()
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

func getCurrentWeatherData() -> Void {
    let baseURL = NSURL(string: "https://api.forecast.io/forecast/3f60bce32cdff52c184189c2db6c0007/\(apiKey)")
    let forecastURL = NSURL(string: "40.484089,-74.283029", relativeToURL: baseURL)
    println(forecastURL)
    
    let sharedSession = NSURLSession.sharedSession()
    //temporarily store JSON data at location
    let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response:NSURLResponse!, error:NSError!) -> Void in
        
        if error == nil {
            let dataObject = NSData(contentsOfURL: location)
            let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
            println(weatherDictionary)
            let currentWeather = CurrentWeather(weatherDictionary: weatherDictionary)
            println(currentWeather.currentTime!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tempLabel.text = "\(currentWeather.temperature)"
                self.summaryLabel.text = "\(currentWeather.summary)"
             
               self.currentTimeLabel.text = "\(currentWeather.currentTime!)"
            })
        } else {
            let networkIssueController = UIAlertController(title: "Error", message: "Unable to load data, connectivity error.", preferredStyle: .Alert)
            let okayButton = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            networkIssueController.addAction(okayButton)
            networkIssueController.addAction(cancelButton)
            self.presentViewController(networkIssueController, animated: true, completion: nil)
        }
    })
    downloadTask.resume()
}
}
