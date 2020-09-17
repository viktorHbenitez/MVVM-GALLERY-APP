//
//  PhotoListCellViewModel.swift
//  MVVM_Gallery_App
//
//  Created by Victor Hugo Benitez Bosques on 9/17/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation


struct PhotoListCellViewModel: PhotoListCellProtocol {
    private var bsPhoto : Photo
    
    init(bsPhoto : Photo) {
        self.bsPhoto = bsPhoto
    }
    
    var title : String {
        return self.bsPhoto.name
    }
    
    var description : String {
        return "\(bsPhoto.camera ?? "") - \(bsPhoto.description ?? "")"
    }
    
    var date : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: bsPhoto.created_at)
    }
    
    var imgURL : String{
        return bsPhoto.image_url
    }
    
}
