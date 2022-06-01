//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Алина on 01.06.2022.
//

import UIKit

class MainViewController: UITableViewController {
    let restaurantNames = ["Koneko bistro", "Vicini Italiani", "ГОСТИ", "Trattria No 5",
                        "Fujiwara YOSHI", "Чичико", "Chornomorka", "Italiano Vero",
                        "GAGA", "MIlkBar", "Honey", "Come and Stay"]

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }

     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = restaurantNames[indexPath.row]
        return cell
    }
     

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
