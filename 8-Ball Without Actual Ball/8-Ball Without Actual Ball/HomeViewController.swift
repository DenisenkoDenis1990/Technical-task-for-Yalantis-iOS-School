//
//  HomeViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Denys Denysenko on 12.01.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var callToShakeText: UILabel!
    var magic = Magic(answer: "")
    var hardcodedAnswers = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callToShakeText.text = """
            Need some answers?
            Shake me
            """
        
       if let vc = storyboard?.instantiateViewController(identifier: "Settings") as? SettingsViewController
       {
        hardcodedAnswers = vc.defaults.stringArray(forKey: "answers")!
       }
        
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        callToShakeText.text = ""
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        let urlString = "https://8ball.delegator.com/magic/JSON/string"
        if let url = URL(string: urlString) {
            
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                
            }
            else {
                magic.answer = hardcodedAnswers.randomElement()!
            }
            callToShakeText.text = magic.answer
            
        }
        
    }
    
    func parse (json: Data) {
        
        let decoder = JSONDecoder()
        if let jsonData = try? decoder.decode(Root.self, from: json){
            magic.answer = jsonData.magic.answer
            dump(jsonData)
        }
         
    }
    
}
