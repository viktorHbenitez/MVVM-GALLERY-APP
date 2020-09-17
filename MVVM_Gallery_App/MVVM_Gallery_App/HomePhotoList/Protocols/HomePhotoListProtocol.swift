//
//  HomePhotoListProtocol.swift
//  MVVM_Gallery_App
//
//  Created by Victor Hugo Benitez Bosques on 9/17/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation
protocol PhotoListCellProtocol {
    var title : String { get }
    var description : String { get }
    var date : String {get}
    var imgURL : String {get}
}
