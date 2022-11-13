//
//  ViewController.swift
//  assignment_5
//
//  Created by user227341 on 11/11/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    var actors = [Result]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
        getDataFromAPI()
        
    }
    var page = "https://swapi.dev/api/people"
    var nextPage = "https://swapi.dev/api/people"
    var prevPage = "https://swapi.dev/api/people"
    @IBAction func requestButton(_ sender: Any) {
        getDataFromAPI()
        
    }
    @IBAction func prevButton(_ sender: Any) {
        page = prevPage
        self.myTableView.reloadData()
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        page = nextPage
        self.myTableView.reloadData()
    }
    
    func getDataFromAPI(){
        //convers string to URL format
        guard let url = URL(string: page) else {
            print("Failed to get to url")
            return
        }
        //Get request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [self]
            data, response, error in
            
            if let data = data , let str = String(data: data, encoding: .utf8){
                let decoder = JSONDecoder()
                do{
                    let parsedData = try? decoder.decode(StarWars.self, from: data)
                    self.actors = parsedData!.results!
                    //self.nextPage = parsedData!.next!
                    
                    
                    print("The data:\(parsedData?.results)")
                    
                }catch{
                    print(error)
                }
                //print(str)
            }
            
        }
        task.resume()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        let name = actors[indexPath.row].name!
        let eyeColor = actors[indexPath.row].eye_color!
        let hairColor = actors[indexPath.row].hair_color!
        let homeworld  = actors[indexPath.row].homeworld!
        let output = "name - \(name) \n eye color - \(eyeColor) \n hair color - \(hairColor) \n homeworld - \(homeworld)"
        cell.titleLable.text = output
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }


}

