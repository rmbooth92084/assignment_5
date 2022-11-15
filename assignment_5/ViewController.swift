//
//  ViewController.swift
//  assignment_5
//
//  Created by Raymond Booth on 11/11/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    var actors = [Result]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Actors"
        // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
        getDataFromAPI()
        
    }
 
    @IBAction func requestButton(_ sender: Any) {
        getDataFromAPI()
        
    }
    @IBAction func prevButton(_ sender: Any) {
        self.myTableView.reloadData()
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        self.myTableView.reloadData()
    }
    
    
    
    var pageNum = 1
    func getDataFromAPI(){
        //convers string to URL format
        guard let url = URL(string: "https://swapi.py4e.com/api/people/?page=\(pageNum)") else {
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
                    self.actors += parsedData?.results ?? []

                    
                    
                    print("The data:\(parsedData?.results)")
                    
                }catch{
                    print(error)
                }
                //print(str)
            }
            
        }
        task.resume()
        sleep(1)
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
        
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
        //paginaiton
        if indexPath.item == actors.count - 1{
         print("fetch more data")
            if(pageNum < 9){
                pageNum += 1
                getDataFromAPI()
            }
            else{
                print("end of list")
            }
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    var place = 0
    //This fuction deals with tapping the a cell and sending all the details to the second VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       //completionHandler?()
        
        print("You tapped \(indexPath.row)")
        place = indexPath.row
        let actor = actors[indexPath.row]

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(place > -1){
            if let des = segue.destination as? DetailsViewController {
                des.name = actors[place].name!
                des.hairColor = actors[place].hair_color!
                des.eyeColor = actors[place].eye_color!
                des.homeWorld = actors[place].homeworld!
                des.films = actors[place].films
            }
        }
    }


}

