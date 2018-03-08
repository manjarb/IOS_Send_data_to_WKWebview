//
//  ViewController.swift
//  TestingWebview
//
//  Created by Varis DARASIRKUL on 6/3/2018.
//  Copyright © 2018 Varis DARASIRKUL. All rights reserved.
//

import UIKit
import WebKit

//class AllInfo: AnyObject {
//    var title = "Special Title"
//    var description = "Special Description"
//}

class ViewController: UIViewController {
    
    var webView : WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // loading URL :
        let myBlog = "http://amusexd.com/"
        let url = NSURL(string: myBlog)
        let request = NSURLRequest(url: url! as URL)
        
        // init and load request in webview.
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: self.view.frame, configuration: configuration)
        webView.navigationDelegate = self
        // webView.uiDelegate = self
        view.addSubview(webView)
        // self.view.sendSubview(toBack: webView)
        
        webView.load(request as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- WKNavigationDelegate

    
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("finish to load eaoe")
        // self.evaluateJavaScriptForData(dictionaryData: ["randomshit": "randomshit" as AnyObject])
    
    }
    
    func evaluateJavaScriptForData(dictionaryData: [String: AnyObject]) {
        // Convert swift dictionary into encoded json
        let serializedData = try! JSONSerialization.data(withJSONObject: dictionaryData, options: .prettyPrinted)
        let encodedData = serializedData.base64EncodedData(options: .endLineWithCarriageReturn)
    
        self.webView.evaluateJavaScript("reloadData('\(encodedData)')", completionHandler: { result, error in
            print("Completed Javascript evaluation.")
            print("Result: \(result)")
            print("Error: \(error)")
        })
    }
    

}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished navigating to url \(webView.url)")
        
        let dictionaryData = ["randomshit": "randomshit" as AnyObject]
        let serializedData = try! JSONSerialization.data(withJSONObject: dictionaryData, options: .prettyPrinted)
        let encodedData = serializedData.base64EncodedString(options: .endLineWithLineFeed)
        
        print(encodedData)
        
        self.webView.evaluateJavaScript("reloadData('\(encodedData)')", completionHandler: { result, error in
            print("Completed Javascript evaluation.")
            print("Result: \(result)")
            print("Error: \(error)")
        })
    }
    
}

