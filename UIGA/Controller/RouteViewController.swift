//
//  RouteViewControllerTableViewController.swift
//  UIGA
//
//  Created by Nikita Sibirtsev on 22/03/2022.
//

import UIKit
import CoreData


class RouteViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var routeList = [RouteList]()
    var waypoints = [Waypoint]()
    
    
    
    var routes: [RouteCordModel] = []
    let a1 = RouteCordModel(route: ["12" : (1.0, 1.0),
                                    "13" : (2, 2),
                                    "14" : (3, 3)], name: "A1")
    let a2 = RouteCordModel(route: ["15" : (10.0, 10.0),
                                    "16" : (20, 20),
                                    "17" : (30, 30)], name: "A2")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        
        
        routes.append(a1)
        routes.append(a2)
        
        tableView.rowHeight = 80.0
        tableView.separatorInset = .zero
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func addRouteButton(_ sender: UIBarButtonItem) {
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    private func delete(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") {[weak self] (_, _, _) in
            guard let self = self else {return}
            self.routes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
        return action
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = delete(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = routes.count
        print(row)
        return row
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = routes[indexPath.row].name
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.6795087294, blue: 0.1318702418, alpha: 1)
        return cell
    }



}
