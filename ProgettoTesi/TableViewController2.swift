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
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.transform = CGAffineTransform.init(scaleX: 3.5, y: 3.5)
        self.activityIndicator.color = UIColor.red
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        callAPI()
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
        cell.avvenimentoText.text = String(utenti[indexPath.row].nPeople) + "People Without Mask"
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
        //(segue.destination as! ViewController2).utenti = utenti[riga!]
        let urll = URL(string: "https://td4.andromedaesp.it/api/demo/detail")
        let x = ["timestamp": utenti[riga!].timestamp, "type": utenti[riga!].type] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: x, options: [])
        var request = URLRequest(url: urll!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            if let c = response as? HTTPURLResponse, c.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(c.statusCode)")
            }
            do{
                let land = try JSONDecoder().decode([Detail].self, from: data!)
                self.utenti[riga!].size = land[0].size
                self.utenti[riga!].media = land[0].media
                self.utenti[riga!].location = land[0].location
                self.utenti[riga!].description = land[0].description
                self.utenti[riga!].urlMedia = land[0].url!
                
                
                //here dataResponse received from a network request
                //let jsonResponse = try JSONSerialization.jsonObject(with:
                //  dataResponse, options: [])
            } catch let parsingError {
                print("Error", parsingError)
            }
        }.resume()
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
    
    
    func callAPI(){
        let url = URL(string: "https://td4.andromedaesp.it/api/demo/history")
        let y = ["batchIndex": 1, "batchSize": 10, "reverseOrder": true, "time": 1593705153000, "type": "Mask"] as [String : Any]
        let jsonDataa = try! JSONSerialization.data(withJSONObject: y, options: [])
        var requestt = URLRequest(url: url!)
        requestt.httpMethod = "POST"
        requestt.setValue("application/json", forHTTPHeaderField: "Accept")
        requestt.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestt.httpBody = jsonDataa
        
        let taskk = URLSession.shared.dataTask(with: requestt) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            if let c = response as? HTTPURLResponse, c.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(c.statusCode)")
                print("response = \(response)")
            }
            do{
                //here dataResponse received from a network request
                let land = try JSONDecoder().decode([UtentiHystory].self, from: data!)
                for x in 0..<land.count{
                    self.utenti.append(Utente(timestamp: land[x].timestamp, type: land[x].type, nPeople: land[x].value.nPeople))
                    switch land[x].value.nPeople {
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
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }.resume()
    }
    
    //    func Post(completionHandler: @escaping ([UtentiHystory]) -> Void){
    //        let url = URL(string: "https://td4.andromedaesp.it/api/demo/history")
    //        let y = ["batchIndex": 1, "batchSize": 5, "reverseOrder": true, "time": 1593705153000, "type": "Mask"] as [String : Any]
    //        let jsonDataa = try! JSONSerialization.data(withJSONObject: y, options: [])
    //        var requestt = URLRequest(url: url!)
    //        requestt.httpMethod = "POST"
    //        //request.httpBody = postString.data(using: String.Encoding.utf8);
    //        //
    //
    //        requestt.setValue("application/json", forHTTPHeaderField: "Accept")
    //        requestt.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //        requestt.httpBody = jsonDataa
    //        //
    //
    //        let taskk = URLSession.shared.dataTask(with: requestt) {(data, response, error) in
    //            guard let dataResponse = data,
    //                error == nil else {
    //                    print(error?.localizedDescription ?? "Response Error")
    //                    return }
    //            if let c = response as? HTTPURLResponse, c.statusCode != 200 {
    //                // check for http errors
    //                print("statusCode should be 200, but is \(c.statusCode)")
    //                print("response = \(response)")
    //            }
    //            do{
    //                //here dataResponse received from a network request
    //                let l = try JSONDecoder().decode([UtentiHystory].self, from: data!)
    //                completionHandler(l)
    //                //let jsonResponse = try JSONSerialization.jsonObject(with:
    //                //dataResponse, options: [])
    //                //print("xx")
    //                //                for x in land{
    //                //                    self.utenti.append(Utente(timestamp: x.timestamp , type: x.type, nPeople: x.value.nPeople))
    //                //                    print("eee")
    //                //                }
    //            } catch let parsingError {
    //                print("Error", parsingError)
    //            }
    //        }.resume()
    //    }
}
