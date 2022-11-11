//
//  ViewController.swift
//  assignment_5
//
//  Created by user227341 on 11/11/22.
//

import UIKit

class ViewController: UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func requestButton(_ sender: Any) {
        getDataFromAPI()
    }
    func getDataFromAPI(){
        //convers string to URL format
        guard let url = URL(string: "https://swapi.dev/api/people") else {
            print("Failed to get to url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let data = data , let str = String(data: data, encoding: .utf8){
                print(str)
            }
            
        }
        task.resume()
        
    }


}

