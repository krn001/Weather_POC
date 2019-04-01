//
//  ItemTblCell.swift
//  Weather_POC
//
//  Created by mac on 01/04/19.
//  Copyright © 2019 kiranJuware. All rights reserved.
//

import UIKit
import Foundation

open class ItemTblCell : UITableViewCell {
    
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var placeLbl: UILabel!
    class var identifier: String { return NSStringFromClass(self).components(separatedBy: ".").last! }
    
    
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    open func setup() {
        
        
    }
    
    
    
    
    open func setData(_ data: Any?) {
        
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
    
    // ignore the default handling
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
}



