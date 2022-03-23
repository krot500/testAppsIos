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
    
    
    // teporary stuff for test
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
        
        tableView.rowHeight = 80.0
        tableView.separatorInset = .zero
        
        loadRouteList()
        
        
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        addMenu(for: button)
        
        
        routes.append(a1)
        routes.append(a2)
        
        
        
    }
    
    

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // deletes rows from table
    private func delete(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") {[weak self] (_, _, _) in
            guard let self = self else { return }
            //self.routes.remove(at: indexPath.row)
            self.routeList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
            self.saveRouteList()
        }
        return action
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = delete(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
    
    //MARK: - change row for row1
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let row = routes.count
        let row = routeList.count
        return row
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = routes[indexPath.row].name
        cell.textLabel?.text = routeList[indexPath.row].name
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.6795087294, blue: 0.1318702418, alpha: 1)
        return cell
    }
    
    
    
    //MARK - CoreData stuff
    
    private func loadRouteList() {
        let request: NSFetchRequest<RouteList> = RouteList.fetchRequest()
        do {
            try routeList = context.fetch(request)
        } catch {
            print("Loading error \(error)")
        }
    }
    


    private func saveRouteList() {
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }

    //MARK: - Creation of button for navigation bar manually
    
    let button = UIButton(type: .system)
    func addMenu(for button: UIButton) {
        let newRoute = UIAction(title: "New Route", image: nil) {action in
            print("rrr")
        }
        let newWaypoint = UIAction(title: "New Waypoint", image: nil) {action in
            print("www")
            
        }
        let menu = UIMenu(title: "", options: .displayInline, children: [newRoute, newWaypoint])
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
    }
   
    
    
}

