//
//  ViewController.swift
//  WEBViewGWP
//
//  Created by JeeYong LEE on 2020/08/07.
//  Copyright © 2020 JeeYong LEE. All rights reserved.
//

import UIKit
import WebKit
import UserNotifications

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet var web_view: WKWebView!
    var theBool: Bool!
    var myTimer: Timer!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var url:URL?
    var ad = UIApplication.shared.delegate as? AppDelegate
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = URL(string: "http://gw.koiware.co.kr:2012/login.do")
        
        //알림 권한 요청
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in print("Did Allow")})
        
        NotificationCenter.default.addObserver(self, selector:Selector(("PushReceiver:")), name: NSNotification.Name(rawValue: "PushReceived"), object: nil)
        
        let request = URLRequest(url: url!)
        web_view.navigationDelegate = self
        web_view.load(request)
        // Do any additional setup after loading the view.
    }
    
    //When post notification then below method is called.
    func PushReceiver(notifi: NSNotification)
    {
        let dicNotifi: [NSObject : AnyObject] = notifi.userInfo! as [NSObject : AnyObject]
        print("notificiation Info %@ \n", dicNotifi)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func loadview(){
        super.loadView()
        web_view = WKWebView(frame: self.view.frame)
        web_view.uiDelegate = self
        web_view.navigationDelegate = self
        
        self.view = self.web_view!
        
    }


    
    
    
    
    
    //웹뷰
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let otherAction = UIAlertAction(title: "OK", style: .default, handler: {action in completionHandler()})
        alert.addAction(otherAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: {(action) in completionHandler(false)})
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in completionHandler(true)})
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .UIActivityIndicatorView.Style.large)
        activityIndicator.frame = CGRect(x: view.frame.midX-50, y: view.frame.midY-50, width: 100, height: 100)
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        //activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
}

