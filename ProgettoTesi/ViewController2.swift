//
//  ViewController2.swift
//  ProgettoTesi
//
//  Created by mgonline on 15/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var avvenimentoDettaglio: UILabel!
    @IBOutlet weak var imgDettagli: UIImageView!
    @IBOutlet weak var dataDettaglio: UILabel!
    @IBOutlet weak var locationDettaglio: UILabel!
    @IBOutlet weak var imgUtente: UIImageView!
    @IBOutlet weak var media: UILabel!
    var caricato : Bool = false
    var utenti : Utente?
    var activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
        self.activityIndicator.color = UIColor.red
        self.activityIndicator.frame.origin.x = (self.imgUtente.frame.width/2) - self.imgUtente.frame.origin.x
        self.activityIndicator.frame.origin.y =  (self.imgUtente.frame.origin.y) + self.imgUtente.frame.height/2
        print(self.view.frame.width)
        print(self.activityIndicator.frame.origin.y)
        print(self.activityIndicator.frame.origin.x)
        //self.activityIndicator.frame.pos = imgUtente.frame.midX
        //self.activityIndicator.frame.maxY = imgUtente.frame.midY
        self.activityIndicator.hidesWhenStopped = true
        view.addSubview(self.activityIndicator)
        
       // self.activityIndicator.startAnimating()
        avvenimentoDettaglio.text = "\(utenti!.nPeople) People Without Mask"
        imgDettagli.image = utenti?.imgHystory
        locationDettaglio.text = utenti?.location
        let data = try? Data(contentsOf: URL(string: "https://td4.andromedaesp.it\(utenti!.urlMedia)")!)
        imgUtente.image = UIImage(data: data!)
        media.text = utenti!.media
        let date = Date(timeIntervalSince1970: TimeInterval(utenti!.timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM-dd-y HH:mm:ss"
        dataDettaglio.text = dateFormatter.string(from: date)
        DispatchQueue.main.async{
            self.viewDidLoad()
            //self.activityIndicator.stopAnimating()
        }
        // Do any additional setup after loading the view.
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
