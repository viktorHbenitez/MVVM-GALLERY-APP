//
//  Extension.swift
//  MVVM_Gallery_App
//
//  Created by Victor Hugo Benitez Bosques on 9/10/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit.UITableViewCell


extension String{
    var identifierString : String{
        return String(describing: self)
    }
}


extension UITableViewCell{
    static var identifierCell : String{
        return String(describing: self)
    }
    
    
}
