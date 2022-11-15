//
//  DetailsViewController.swift
//  assignment_5
//
//  Created by user227341 on 11/15/22.
//

import UIKit

class DetailsViewController: UIViewController {

    var name = ""
    var eyeColor = ""
    var hairColor = ""
    var homeWorld = ""
    var films : [String]?
    var temp = ""
    
    var data = [Result]()
    @IBOutlet weak var detailsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"

        for val in films!{
            temp += "\n \(val)"
        }
        detailsLabel.text = "name: \(name)\n eye color: \(eyeColor)\n hair color: \(hairColor)\n homeworld: \(homeWorld)\n films: \n\(temp)"
        
    }
    

    

}
