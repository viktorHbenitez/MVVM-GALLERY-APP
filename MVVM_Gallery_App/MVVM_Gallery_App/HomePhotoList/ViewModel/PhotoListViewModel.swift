//
//  PhotoListViewModel.swift
//  MVVMPlayground
//
//  Created by Neo on 03/10/2017.
//  Copyright © 2017 ST.Huang. All rights reserved.
//

import Foundation

class PhotoListViewModel {
    
    let apiService: APIServiceProtocol

    private var photos: [Photo] = [Photo]()
    
    private var cellViewModels: [PhotoListCellViewModel] = [PhotoListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var isAllowSegue: Bool = false
    
    var selectedPhoto: Photo?

    // MARK: - Binding
    var reloadTableViewClosure: (()->())?  // reload tableview
    var showAlertClosure: (()->())?        // Show the AlertMessage
    var updateLoadingStatus: (()->())?     // start and stop the service indicator

    init( apiService: APIServiceProtocol = APIService()) {  // DI
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true // show the activity indicador
        apiService.fetchPopularPhoto { [weak self] (success, photos, error) in
            self?.isLoading = false // stop loading activity indicator
            if let error = error {
                self?.alertMessage = error.rawValue // init the closure error message
            } else {
                self?.processFetchedPhoto(photos: photos)
            }
        }
    }
    
    // get the object cell
    func getCellViewModel( at indexPath: IndexPath ) -> CellInterface {
        return cellViewModels[indexPath.row]
    }
    
//    // parse objects service to a model
//    func createCellViewModel( photo: Photo ) -> PhotoListCellViewModel {
//
//        //Wrap a description
//        var descTextContainer: [String] = [String]()
//        if let camera = photo.camera {
//            descTextContainer.append(camera)
//        }
//        if let description = photo.description {
//            descTextContainer.append( description )
//        }
//        let desc = descTextContainer.joined(separator: " - ")
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//
//        return PhotoListCellViewModel( titleText: photo.name,
//                                       descText: desc,
//                                       imageUrl: photo.image_url,
//                                       dateText: dateFormatter.string(from: photo.created_at) )
//    }
//
    private func processFetchedPhoto( photos: [Photo] ) {
        self.photos = photos // Cache
        self.cellViewModels = photos.map{PhotoListCellViewModel(bsPhoto: $0)}
    }
    
}

extension PhotoListViewModel {
    func userPressed( at indexPath: IndexPath ){
        let photo = self.photos[indexPath.row]
        if photo.for_sale {
            self.isAllowSegue = true
            self.selectedPhoto = photo
        }else {
            self.isAllowSegue = false
            self.selectedPhoto = nil
            self.alertMessage = "This item is not for sale" // invoke show alertClosure
        }
        
    }
}

protocol CellInterface {
    var title : String { get }
    var description : String { get }
    var date : String {get}
    var imgURL : String {get}
}

struct PhotoListCellViewModel: CellInterface {
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
