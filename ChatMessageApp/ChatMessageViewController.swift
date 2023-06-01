//
//  ChatMessageViewController.swift
//  ChatMessageApp
//
//  Created by Anshumali Karna on 01/06/23.
//

import UIKit

@objc class ChatMessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        
        button.backgroundColor = .blue
        button.center = self.view.center
        button.layer.cornerRadius = 20
        
        button.setTitle("Hello", for: .normal)
        self.view.addSubview(button)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
