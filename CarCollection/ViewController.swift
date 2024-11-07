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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        field.delegate = self
        table.dataSource = self
    }


}

