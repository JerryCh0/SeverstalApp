//
//  ViewController.swift
//  Severstal
//
//  Created by Дмитрий Ткаченко on 03/03/2018.
//  Copyright © 2018 bsws. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var severstalImage: UIImageView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotate1(imageView: UIImageView, aCircleTime: Double) { //CABasicAnimation
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = -Double.pi * 2 //Minus can be Direction
        rotationAnimation.duration = aCircleTime
        rotationAnimation.repeatCount = .infinity
        imageView.layer.add(rotationAnimation, forKey: nil)
    }
    
    func stopAnimate(imageView: UIImageView) {
        imageView.stopAnimating()
    }
    
    @IBAction func enterAction(_ sender: UIButton) {
        
        self.rotate1(imageView: self.severstalImage, aCircleTime: 1.5)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.loginField.alpha = 0
            self.pwdField.alpha = 0
            self.enterButton.alpha = 0
            self.loadingLabel.alpha = 1
        }, completion: { (boolka) in
            
            DispatchQueue.global(qos: .background).async {
                sleep(2)
                DispatchQueue.main.async {
                    
                    let nextController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                    
                    self.present(nextController, animated: true, completion: nil)
                }
            }
        })
        
        
        
//        UIView.animate(withDuration: 2.0, animations: {
//            self.severstalImage.transform = CGAffineTransform(rotationAngle: 2 * .pi)
//        }, completion: { (boolka) in
//
//        })
        
        
    }
    


}

