//
//  TableViewCell.swift
//  ProgettoTesi
//
//  Created by mgonline on 15/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var avvenimentoText: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()     
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        fineAnimazione()
    }
    
    func animaCella(){
        UIView.beginAnimations("", context: nil)
        UIView.setAnimationDuration(0.7)
        layer.transform = CATransform3DIdentity
        alpha = 1
        UIView.commitAnimations()
    }
    
    func fineAnimazione(){
        alpha = 0
        layer.transform = CATransform3DMakeRotation((90 * .pi)/180, 0, 0.3, 0.2)
        layer.anchorPoint = CGPoint(x: 0, y: 0)
    }

}
