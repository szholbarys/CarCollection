//
//  ViewController.swift
//  CarCollection
//
//  Created by Zholbarys on 07.11.2024.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!
    
    var cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(CarTableViewCell.nib(), forCellReuseIdentifier: CarTableViewCell.identifier)
        table.delegate = self
        field.delegate = self
        table.dataSource = self
    }
    
    //Field
    func textFiledShouldReturn(_ textField: UITextField) -> Bool {
        searchCars()
        return true
    }
    
    func searchCars(){
        field.resignFirstResponder()
        
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        
        cars.removeAll()
        
        URLSession.shared.dataTask(with: URL(string: "")!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                return
            }
 
            var result: CarResult?
            do {
                result = try JSONDecoder().decode(CarResult.self, from: data)
            }
            catch {
                print("error")
            }
            
            guard let finalResult = result else {
                return
            }
                        
            // update cars array
            let newCars = finalResult.Search
            self.cars.append(contentsOf: newCars)
            
            // refresh our table
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }).resume()
    }
    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.identifier, for: indexPath) as! CarTableViewCell
        cell.configure(with: cars[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

struct CarResult: Codable {
    let Search: [Car]
}
struct Car: Codable {
    let Title: String
    let Year: String
    let Id: String
    let _Type: String
    let Poster: String
    
    private enum CodingKeys: String, CodingKey {
        case Title, Year, Id, _Type = "Type", Poster
    }
}
