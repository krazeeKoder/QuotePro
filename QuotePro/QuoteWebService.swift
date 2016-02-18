//
//  QuoteWebService.swift
//  QuotePro
//
//  Created by Anthony Tulai on 2016-02-17.
//  Copyright © 2016 Anthony Tulai. All rights reserved.
//

import Foundation

class QuoteWebService {
    
    func getQuoteAndAuthor(completionHandler:(String, String) -> Void) {
        let quoteEndpoint: String = "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json"
        guard let url = NSURL(string: quoteEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET")
                print(error)
                return
            }
            // parse the result as JSON, since that's what the API provides
            let post: NSDictionary
            do {
                post = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! NSDictionary
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
            if let postQuote = post["quoteText"] as? String, postAuthor = post["quoteAuthor"] as? String {
                completionHandler(postQuote, postAuthor)
            }

        })
        task.resume()
    }
}

