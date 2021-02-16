//
//  TableViewController2.swift
//  ProgettoTesi
//
//  Created by mgonline on 15/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import UIKit

class TableViewController2: UITableViewController {
    
    var utenti : [UtentiCovid] = [UtentiCovid]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateNow = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: dateNow)
        for x in 1...10{
            //let data = "11-04-1991"
            let tmp = Int.random(in: 1..<7)
            let date = String(components.day!) + " " + String(components.year!) + " " + String(components.day! + x)
            utenti.append(UtentiCovid(avvenimento: String(x), data: date, numeroPersone: String(Int.random(in: 1...3))))
            switch utenti[x-1].numeroPersone {
            case "1":
                utenti[x-1].img = UIImage(systemName: "person.fill")!
                utenti[x-1].imgUtente = UIImage(named: "mascherina")
            case "2":
                utenti[x-1].img = UIImage(systemName: "person.2.fill")!
                utenti[x-1].imgUtente = UIImage(named: "mascherina2")
            case "3":
                utenti[x-1].img = UIImage(systemName: "person.3.fill")!
                utenti[x-1].imgUtente = UIImage(named: "mascherina3")
            default:
                break
            }
            
            switch tmp {
            case 1:
                utenti[x-1].location = Location(rawValue: "Roma")
            case 2:
                utenti[x-1].location = Location(rawValue: "Torino")
            case 3:
                utenti[x-1].location = Location(rawValue: "Napoli")
            case 4:
                utenti[x-1].location = Location(rawValue: "Catanzaro")
            case 5:
                utenti[x-1].location = Location(rawValue: "Firenze")
            case 6:
                utenti[x-1].location = Location(rawValue: "Palermo")
            case 7:
                utenti[x-1].location = Location(rawValue: "Milano")
            default:
                break
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return utenti.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cella", for: indexPath) as! TableViewCell
        cell.avvenimentoText.text = utenti[indexPath.row].avvenimento
        cell.data.text = utenti[indexPath.row].data
        cell.img.image = utenti[indexPath.row].img
        //print("---------------")
        //print(cell.frame.size.height)
        // Configure the cell...
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier != nil else{
            return
        }
        let riga = sender as? Int
        (segue.destination as! ViewController2).utenti = utenti[riga!]
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DettaglioUtente", sender: indexPath.row)
    }
}
