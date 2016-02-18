//
//  NewQuotPicViewController.swift
//  QuotePro
//
//  Created by Anthony Tulai on 2016-02-17.
//  Copyright © 2016 Anthony Tulai. All rights reserved.
//

import UIKit
import Nuke
import Graph


class NewQuotPicViewController: UIViewController {
    
    let quoteLabel = UILabel()
    let authorLabel = UILabel()
    var quoteImageView = UIImageView ()
    //var newQuote = Entity.init(type: "Quote")
    var author = String()
    var quote = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.generateRandomPictureButton()
        self.generateRandomQuoteButton()
        self.addSaveButton()
        self.addCancelButton()
        self.addQuoteImageView()

        // Do any additional setup after loading the view.
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Add UI Elements
    
    func addColorButtons () {
        let redButton = UIButton(type: UIButtonType.System) as UIButton
        let blueButton = UIButton(type: UIButtonType.System) as UIButton
        let greenButton = UIButton(type: UIButtonType.System) as UIButton
        let yellowButton = UIButton(type: UIButtonType.System) as UIButton
        let purpleButton = UIButton(type: UIButtonType.System) as UIButton
        let orangeButton = UIButton(type: UIButtonType.System) as UIButton
        let blackButton = UIButton(type: UIButtonType.System) as UIButton
        let whiteButton = UIButton(type: UIButtonType.System) as UIButton
        
        redButton.frame = CGRectMake(self.view.frame.height * 0.05, self.view.frame.width * 0.3, 50, 50)
        redButton.backgroundColor = UIColor.redColor()
        redButton.addTarget(self, action: "setRedColor", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(redButton)
        
        yellowButton.frame = CGRectMake(self.view.frame.height * 0.25,25, 100, 50)
        
        
        
    }
    
    func generateRandomPictureButton() {
        let randomPictureButton = UIButton(type: UIButtonType.System) as UIButton
        randomPictureButton.frame = CGRectMake(self.view.frame.height * 0.25,25, 100, 50)
        randomPictureButton.backgroundColor = UIColor.whiteColor()
        randomPictureButton.setTitle("Random Pic", forState: UIControlState.Normal)
        randomPictureButton.addTarget(self, action: "setRandomPicture", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(randomPictureButton)
    }
    
    func generateRandomQuoteButton() {
        let randomQuoteButton = UIButton(type: UIButtonType.System) as UIButton
        randomQuoteButton.frame = CGRectMake(self.view.frame.height * 0.5, 25, 150, 50)
        randomQuoteButton.backgroundColor = UIColor.whiteColor()
        randomQuoteButton.setTitle("Random Quote", forState: UIControlState.Normal)
        randomQuoteButton.addTarget(self, action: "setRandomQuote", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(randomQuoteButton)
    }
    
    func addSaveButton() {
        let saveButton = UIButton(type: UIButtonType.System) as UIButton
        saveButton.frame = CGRectMake(self.view.frame.height * 0.25, self.view.frame.width * 0.85, 150, 50)
        saveButton.backgroundColor = UIColor.whiteColor()
        saveButton.setTitle("Save", forState: UIControlState.Normal)
        saveButton.addTarget(self, action: "saveQuote", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(saveButton)
    }
    
    func addCancelButton() {
        let cancelButton = UIButton(type: UIButtonType.System) as UIButton
        cancelButton.frame = CGRectMake(self.view.frame.height * 0.5, self.view.frame.width * 0.85, 150, 50)
        cancelButton.backgroundColor = UIColor.whiteColor()
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.addTarget(self, action: "cancelQuote", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(cancelButton)
    }
    
    func addQuoteImageView() {
        let imageName = "default"
        let image = UIImage(named: imageName)
        self.quoteImageView = UIImageView(image: image!)
        self.quoteImageView .frame = CGRect(x: self.view.frame.height*0.1, y: self.view.frame.width*0.2, width: self.view.frame.height*0.8, height: self.view.frame.width*0.6)
        self.quoteLabel.frame = CGRectMake(self.quoteImageView .frame.width * 0.1,self.quoteImageView.frame.height * 0.25, 250, 100);
        self.quoteLabel.numberOfLines = 0;
        self.quoteLabel.textColor = UIColor.yellowColor()
        self.quoteLabel.text = "Wake up and smell the roses"
        self.quoteLabel.font = UIFont.italicSystemFontOfSize(14.0)
        self.authorLabel.frame = CGRectMake(self.quoteImageView.frame.width * 0.2,self.quoteImageView.frame.height * 0.6, 200, 50);
        self.authorLabel.numberOfLines = 0;
        self.authorLabel.textColor = UIColor.yellowColor()
        self.authorLabel.text = "God"
        self.authorLabel.font = UIFont.italicSystemFontOfSize(14.0)
        self.quoteImageView .addSubview(self.quoteLabel)
        self.quoteImageView.addSubview(self.authorLabel)
        
        view.addSubview(self.quoteImageView)
    }
    
    //MARK: - Button Methods
    
    func setRandomQuote() {
        QuoteWebService().getQuoteAndAuthor( { (postQuote:String, postAuthor:String) -> Void in
            self.author = postAuthor
            self.quote = postQuote
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.quoteLabel.text = self.quote
                self.authorLabel.text = self.author
            })

        })
    }
    
    func setRandomPicture() {
        let randomNumber = arc4random_uniform(UInt32.max)
        self.quoteImageView.nk_setImageWith(NSURL(string: "https://unsplash.it/1000/600/?random&cache=\(randomNumber)")!)
    }
    
    func saveQuote() {
        
        let graph: Graph = Graph()
        //var newQuote = Quote()
        let image = UIImage.imageWithView(self.quoteImageView)
//        
//        
//        newQuote.image = image
//        newQuote.quoteString = self.quote
//        newQuote.quoteAuthor = self.author
        
        let quoteEntity: Entity = Entity(type: "Quote")
        
        quoteEntity["image"] = image
        quoteEntity["quoteString"] = self.quote
        quoteEntity["quoteAuthor"] = self.author     
        graph.save()
        
        self.dismissViewControllerAnimated(false) { () -> Void in }
        
        
        
        
//        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
//        
//        appDelegate?.addQuote(newQuote)
//        
        //self.quoteImageView.hidden = true
        
    }
    
    func cancelQuote() {
        self.dismissViewControllerAnimated(false) { () -> Void in
        }
    }
    
    
    /*
    // MARK: - Navigation
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    


}
