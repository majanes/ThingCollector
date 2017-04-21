//
//  ViewController.swift
//  ThingCollector
//
//  Created by Mark Janes on 16/04/2017.
//  Copyright © 2017 The Light Machine. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var things : [Thing] = []
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            things = try context.fetch(Thing.fetchRequest())
            tableView.reloadData()
        } catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let thing = things[indexPath.row]
        
        cell.textLabel?.text = thing.title
        cell.imageView?.image = UIImage(data: thing.image as! Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thing = things[indexPath.row]
        performSegue(withIdentifier: "thingSegue", sender: thing)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ThingViewController
        nextVC.thing = sender as? Thing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

