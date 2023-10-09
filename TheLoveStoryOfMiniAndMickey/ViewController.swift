//
//  ViewController.swift
//  TheLoveStoryOfMiniAndMickey
//
//  Created by Cenker Soyak on 9.10.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    var searchBar: UISearchBar = UISearchBar()
    var tableview = UITableView()
    var personList = [Club]()
    var segmentedController : UISegmentedControl = {
        let items = ["Name", "Surname"]
        let segmentControl = UISegmentedControl(items: items)
        return segmentControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    
    func createUI(){
        view.backgroundColor = .white
        
        searchBar.delegate = self
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        
        view.addSubview(segmentedController)
        segmentedController.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(25)
            make.right.equalTo(view.snp.right).offset(-25)
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "contactlist")
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.equalTo(segmentedController.snp.bottom).offset(20)
            make.right.equalTo(view)
            make.left.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.lowercased()
        if segmentedController.selectedSegmentIndex == 0 {
            personList = ViewController.person.filter {$0.name.lowercased().contains(text) }
        } else if segmentedController.selectedSegmentIndex == 1 {
            personList = ViewController.person.filter {$0.surname.lowercased().contains(text)}
        }
        tableview.reloadData()
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.isEmpty ? ViewController.person.count : personList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactlist", for: indexPath)
        if personList.isEmpty {
            cell.textLabel?.text = ViewController.person[indexPath.row].name + " " + ViewController.person[indexPath.row].surname
        } else {
            cell.textLabel?.text = personList[indexPath.row].name + " " + personList[indexPath.row].surname
        }
        
        
        return cell
    }
}

extension ViewController {
    struct Club {
        let name: String
        let surname: String
    }
    
    static var person : [Club] = [
        Club(name: "Minny", surname: "Mouse"),
        Club(name: "Mickey", surname: "Mouse"),
        Club(name: "Donald", surname: "Duck"),
        Club(name: "Daisy", surname: "Duck"),
        Club(name: "Cenker", surname: "Soyak"),
        Club(name: "Berk", surname: "Ceylan"),
        Club(name: "Baki", surname: "Oğuz"),
        Club(name: "Ali", surname: "Mari"),
        Club(name: "Can", surname: "Dost")
    ]
}
