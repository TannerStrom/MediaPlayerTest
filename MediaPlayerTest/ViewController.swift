//
//  ViewController.swift
//  MediaPlayerTest
//
//  Created by Tanner Strom on 10/18/15.
//  Copyright © 2015 Tanner Strom. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

class ViewController: UIViewController {

    var loginButtonTapped: Bool = false;
    var loginBase:UIButton = UIButton();
    var signupBase:UIButton = UIButton();
    
    var name:UITextField = UITextField();
    var password:UITextField = UITextField();
    
    //var title = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setVideoLayer();
        
        //if(loginButtonTapped == true) {
            //self.drawMenu()
            //self.drawTitle()
            //self.drawLoginCancelButtons()
        //}
        
        self.drawBaseLoginButton()
        self.drawBaseSignupButton()
    }
    
    ///
    //
    //Create the AV layer
    //
    ///
    
    func setVideoLayer() {
        let myPlayerView = UIView(frame: self.view.bounds);
        view.addSubview(myPlayerView);
        
        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("ChampsElysees_150610_03_Videvo", withExtension: "mov")!;
        //let videoURL: NSURL = NSBundle.mainBundle().URLForResource("FIRE_PLACE", withExtension: "mov")!;
        
        let player = AVPlayer(URL: videoURL);
        
        player.play();
        player.muted = true;
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.None
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "playerItemDidReachEnd:",
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: player.currentItem)
        
        let avLayer = AVPlayerLayer(player: player);
        avLayer.frame = myPlayerView.bounds;
        avLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        myPlayerView.layer.addSublayer(avLayer);
        
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark);
        let blurView = UIVisualEffectView(effect: blur);
        blurView.alpha = 0.75;
        blurView.frame = self.view.bounds;
        self.view.addSubview(blurView);
    }
    
    ///
    //
    //These elements are for the base login/signin buttons
    //
    ///
    
    func drawBaseLoginButton() {
        let btnWid:CGFloat = self.view.frame.width / 2;
        let btnHei:CGFloat = 55.0;
        
        loginBase = UIButton(frame: CGRectMake(0,
            self.view.frame.height - btnHei,
            btnWid,
            btnHei));
        
        loginBase.backgroundColor = UIColor.grayColor();
        loginBase.alpha = 0.5;
        loginBase.setTitle("Login", forState: UIControlState.Normal);
        loginBase.addTarget(self,
            action: "loginBaseTapped:",
            forControlEvents: UIControlEvents.TouchUpInside);
        
        self.view.addSubview(loginBase);
    }
    
    func drawBaseSignupButton() {
        let btnWid:CGFloat = self.view.frame.width / 2;
        let btnHei:CGFloat = 55.0;
        
        signupBase = UIButton(frame: CGRectMake(self.view.frame.width / 2,
            self.view.frame.height - btnHei,
            btnWid,
            btnHei));
        
        signupBase.backgroundColor = UIColor.grayColor();
        signupBase.alpha = 0.5;
        signupBase.setTitle("Sign Up", forState: UIControlState.Normal);
        
        self.view.addSubview(signupBase);
    }
    
    ///
    //
    //These elements are for after the base login button is tapped
    //
    ///
    
    func drawMenu() {
        let wid:CGFloat = 250.0;
        let hei:CGFloat = 300.0;
        
        let base = UIImageView(frame:CGRectMake(self.view.bounds.width / 2 - (wid / 2),
            self.view.bounds.height / 2 - (hei / 2),
            wid,
            hei));
        
        base.backgroundColor = UIColor.grayColor();
        base.layer.cornerRadius = 8.0;
        base.alpha = 0;
        base.clipsToBounds = true;
        
        self.view.addSubview(base);
        
        //Make the text field
        let inpWid:CGFloat = 200.0;
        let inpHei:CGFloat = 30.0;
        
        name = UITextField(frame: CGRectMake(self.view.bounds.width / 2 - (inpWid / 2),
            self.view.bounds.height / 1.9,
            inpWid,
            inpHei));
        
        name.clipsToBounds = true;
        name.textColor = UIColor.blackColor();
        
        //Only an underline
        let underline = CALayer();
        let undWid:CGFloat = 2.0;
        underline.borderColor = UIColor.blackColor().CGColor;
        underline.frame = CGRectMake(0,
            name.frame.size.height - undWid,
            name.frame.size.width,
            name.frame.size.height)
        
        underline.borderWidth = undWid;
        name.layer.addSublayer(underline);
        name.layer.masksToBounds = true;
        name.placeholder = "Username"
        name.textAlignment = NSTextAlignment.Center;
        name.keyboardType = UIKeyboardType.EmailAddress;
        name.alpha = 0.0;
        
        self.view.addSubview(name);
        
        //Make the text field
        let pasWid:CGFloat = 200.0;
        let pasHei:CGFloat = 30.0;
        
        password = UITextField(frame: CGRectMake(self.view.bounds.width / 2 - (pasWid / 2),
            self.view.bounds.height / 1.7,
            pasWid,
            pasHei));
        
        password.clipsToBounds = true;
        password.textColor = UIColor.blackColor();
        
        //Only an underline
        let pUnderline = CALayer();
        let pUndWid:CGFloat = 2.0;
        pUnderline.borderColor = UIColor.blackColor().CGColor;
        pUnderline.frame = CGRectMake(0,
            password.frame.size.height - pUndWid,
            password.frame.size.width,
            password.frame.size.height)
        
        pUnderline.borderWidth = pUndWid;
        password.layer.addSublayer(pUnderline);
        password.layer.masksToBounds = true;
        password.placeholder = "Password"
        password.textAlignment = NSTextAlignment.Center;
        password.enabled = false;
        password.secureTextEntry = true;
        password.alpha = 0;
        
        self.view.addSubview(password);
        
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                base.alpha = 0.5;
                self.name.alpha = 1.0;
                self.password.alpha = 1.0;
            },
            completion: { finished in
                self.name.enabled = true;
                self.password.enabled = true;
        })
    }
    
    func drawTitle() {
        let wid:CGFloat = 250;
        let hei:CGFloat = 150;
        
        let title = UILabel(frame: CGRectMake(self.view.bounds.width / 2 - (wid / 2),
            self.view.bounds.height / 3 - (hei / 2),
            wid,
            hei));
        title.text = "An Application";
        title.textAlignment = NSTextAlignment.Center;
        title.font = UIFont(name: "GillSans", size: 30);
        title.alpha = 0.0;
        
        self.view.addSubview(title);
        
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                title.alpha = 0.5;
            },
            completion: {
                finished in
        })
    }
    
    func drawLoginCancelButtons() {
        let lgnWid:CGFloat = 200.0;
        let lgnHei:CGFloat = 30.0;
        
        let loginButton: UIButton = UIButton(frame: CGRectMake(self.view.bounds.width / 2 - (lgnWid / 2),
            self.view.bounds.height / 1.47 - (lgnHei / 2),
            lgnWid,
            lgnHei));
        loginButton.backgroundColor = UIColor.clearColor();
        loginButton.layer.cornerRadius = 8.0;
        loginButton.setTitle("Login", forState: UIControlState.Normal);
        loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        loginButton.titleLabel?.font = UIFont(name: "GillSans", size: 20);
        loginButton.alpha = 0.0;
        loginButton.enabled = false;
        
        self.view.addSubview(loginButton);
        
        let canWid:CGFloat = 200.0;
        let canHei:CGFloat = 30.0;
        
        let cancelButton:UIButton = UIButton(frame: CGRectMake(self.view.bounds.width / 2 - (canWid / 2),
            self.view.bounds.height / 1.35,
            canWid,
            canHei))
        cancelButton.backgroundColor = UIColor.clearColor();
        cancelButton.layer.cornerRadius = 8.0;
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal);
        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        cancelButton.titleLabel?.font = UIFont(name: "GillSans", size: 20);
        cancelButton.alpha = 0.0;
        cancelButton.enabled = false;
        
        self.view.addSubview(cancelButton);
        
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                loginButton.alpha = 0.5;
                cancelButton.alpha = 0.5;
            },
            completion: { finished in
                loginButton.enabled = true;
                cancelButton.enabled = true;
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Helpers go down here
    
    func playerItemDidReachEnd(notification: NSNotification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seekToTime(kCMTimeZero)
    }
    
    func loginBaseTapped(sender: UIButton!) {
        loginButtonTapped = true;
        print("Login button tapped");
    
        self.drawMenu();
        self.drawTitle();
        self.drawLoginCancelButtons();
    }

}

