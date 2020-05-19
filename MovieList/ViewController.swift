//
//  ViewController.swift
//  MovieList
//
//  Created by Hanien ElGalfy on 5/19/20.
//  Copyright © 2020 Hanien ElGalfy. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    var tableView:UITableView?
    var items = NSMutableArray()
    var movies = [Movie]()
    override func viewWillAppear(_ animated: Bool) {
        let frame:CGRect = CGRect(x:0 , y:100 , width: self.view.frame.width , height:  self.view.frame.height)
        self.tableView = UITableView(frame: frame)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.view.addSubview(self.tableView!)
        
        let button = UIButton(frame: CGRect(x:0, y:50 , width: self.view.frame.width , height: 50))
        button.backgroundColor = UIColor.black
        button.setTitle("Add new movie", for: UIControl.State.normal)
        button.addTarget(self, action: "addMovies", for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
    }
    func addMovies(){
        NetworkManager.shared.getMovies { (movie) in
            self.movies.append(movie!)
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")as? UITableViewCell
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "CELL")
        }
        let movie:Movie = movies.first!
        let pic = movie.poster_path
        cell?.textLabel?.text = movie.title
        return cell!
        
    }
}

