//
//  UserTableViewController.swift
//  MapppppPPPp
//
//  Created by Преподаватель on 10.12.2021.
//

import UIKit
import MapKit

class UserTableViewController: UITableViewController {

    let users = User().getUser()
    var anotations: [MKAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let users = users else {
            return
        }
        for item in users{
            let antotion = MKPointAnnotation()
            antotion.coordinate = CLLocationCoordinate2D(latitude: Double(item.address.geo.lat) ?? 0,
                                                         longitude: Double(item.address.geo.lng) ?? 0)
            antotion.title = item.name
            
            anotations.append(antotion)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let city = users![indexPath.row].address.city
        let street =  users![indexPath.row].address.street
        let suite = users![indexPath.row].address.suite
        let name = users![indexPath.row].name
        
        cell.textLabel?.text = "\(city), \(street), \(suite)    \n\n(\(name))"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "map") as! ViewController
        vc.anotations = [anotations[indexPath.row]]
        
        show(vc, sender: nil)
        
    }
    @IBAction func showAllUsers(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "map") as! ViewController
        vc.anotations = anotations
        
        show(vc, sender: nil)
    }
    
}
