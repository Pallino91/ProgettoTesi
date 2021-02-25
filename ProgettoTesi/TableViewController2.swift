//
//  TableViewController2.swift
//  ProgettoTesi
//
//  Created by mgonline on 15/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import UIKit

class TableViewController2: UITableViewController {
    
    var utenti = [Utente]()
    var utentiHystoryMask = [UtentiHistoryMaskResponse]()
    var utentiHystoryCorona = [UtentiHistoryCoronaResponse]()
    var utentiDetail = [DetailResponse]()
    var activityIndicator = UIActivityIndicatorView()
    var type : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUtenti()
    }
    
    
    
    
    func loadUtenti(){
        self.activityIndicator.transform = CGAffineTransform.init(scaleX: 3.5, y: 3.5)
        self.activityIndicator.color = UIColor.red
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        switch self.type {
        case "Mask":
            callAPIMask()
        case "Coronavirus":
            callAPICorona()
        case "Task-safety":
            callAPITask()
        case "Crowding":
            callAPICrowding()
        default:
            break
        }
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
        let convertNumberPeople = convertPeople(people: utenti[indexPath.row].nPeople!)
        cell.avvenimentoText.text = convertNumberPeople + " People Without Mask"
        let date = Date(timeIntervalSince1970: TimeInterval(utenti[indexPath.row].timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        print(utenti[indexPath.row].timestamp)
        cell.data.text = dateFormatter.string(from: date)
        cell.img.image = utenti[indexPath.row].imgHystory
        return cell
    }
    
    func convertPeople(people: Int) -> String{
        switch people {
        case 1:
            return "One"
        case 2:
            return "Two"
        case 3...10:
            return "Three or more"
        default:
            return ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier != nil else{
            return
        }
        let riga = sender as? Int
        let serviceDetail = ServiceDetail(time: self.utenti[riga!].timestamp,type: self.utenti[riga!].type)
        serviceDetail.callAPI()
        serviceDetail.completionHandler{ [weak self] (utentiDetail, status, message) in
            if status{
                guard let self = self else {return}
                guard let tmpUtenti = utentiDetail else{return}
                self.utentiDetail = tmpUtenti
                self.utenti[riga!].size = self.utentiDetail[0].size
                self.utenti[riga!].media = self.utentiDetail[0].media
                self.utenti[riga!].location = self.utentiDetail[0].location
                self.utenti[riga!].description = self.utentiDetail[0].description
                self.utenti[riga!].urlMedia = self.utentiDetail[0].url!
            }else{
                print(message)
            }
        }
        (segue.destination as! ViewController2).utenti = self.utenti[riga!]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DettaglioUtente", sender: indexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else{
            return
        }
        cell.animaCella()
    }
    
    func callAPIMask(){
        let serviceHistory = ServiceHystory(type: self.type!)
        serviceHistory.completionHandlerMask{ [weak self] (utentiHystoryMask, status, message) in
            if status{
                guard let self = self else {return}
                guard let tmpUtenti = utentiHystoryMask else{return}
                self.utentiHystoryMask = tmpUtenti
                for x in 0..<self.utentiHystoryMask.count {
                    self.utenti.append(Utente(timestamp: self.utentiHystoryMask[x].timestamp, type: self.utentiHystoryMask[x].type, nPeople: self.utentiHystoryMask[x].value.nPeople))
                    switch self.utentiHystoryMask[x].value.nPeople {
                    case 1:
                        self.utenti[x].imgHystory = UIImage(systemName: "person.fill")
                    case 2:
                        self.utenti[x].imgHystory = UIImage(systemName: "person.2.fill")
                    case 3...10:
                        self.utenti[x].imgHystory = UIImage(systemName: "person.3.fill")
                    default:
                        break
                    }
                }
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }else{
                print(message)
            }
        }
        
    }
    func callAPICorona(){
        let serviceHistory = ServiceHystory(type: self.type!)
        serviceHistory.completionHandlerCorona{ [weak self] (utentiHystoryCorona, status, message) in
            if status{
                guard let self = self else {return}
                guard let tmpUtenti = utentiHystoryCorona else{return}
                self.utentiHystoryCorona = tmpUtenti
                for x in 0..<self.utentiHystoryCorona.count {
                    self.utenti.append(Utente(timestamp: self.utentiHystoryCorona[x].timestamp, type: self.utentiHystoryCorona[x].type, temperature: self.utentiHystoryCorona[x].value.temperature, coughRateMin: self.utentiHystoryCorona[x].value.coughRateMin))
                }
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }else{
                print(message)
            }
        }
    }
    func callAPITask(){
        
    }
    func callAPICrowding(){
        
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
}
