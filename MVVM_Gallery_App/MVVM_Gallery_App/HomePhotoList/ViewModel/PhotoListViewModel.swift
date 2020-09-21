//
//  PhotoListViewModel.swift
//  MVVMPlayground
//
//  Created by Neo on 03/10/2017.
//  Copyright © 2017 ST.Huang. All rights reserved.
//

import Foundation

class PhotoListViewModel {
    
    typealias Closure = () -> ()
    
    let apiService: APIServiceProtocol

    private(set) var photos: [Photo] = [Photo]()
    
    private var cellViewModels: [PhotoListCellViewModel] = [PhotoListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    private(set) var isLoading: Bool = false {  // Activity indicator (start / end) and TableView (show / hide)
        didSet {
            self.updateLoadingStatus?()
        }
    }
    private(set) var alertMessage: String? { // Error message (Show / Hide)
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
    var reloadTableViewClosure: (Closure)?  // reload tableview
    var showAlertClosure: (Closure)?        // Show the AlertMessage
    var updateLoadingStatus: (Closure)?     // start and stop the service indicator

    init(apiService: APIServiceProtocol = APIService()) {  // DI
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true // show the activity indicador
        apiService.fetchPopularPhoto { [weak self] success, photos, error in
            self?.isLoading = false // stop loading activity indicator
            if let error = error {
                self?.alertMessage = error.rawValue //
            } else {
                self?.processFetchedPhoto(photos: photos)
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PhotoListCellProtocol {
        return cellViewModels[indexPath.row]
    }
    private func processFetchedPhoto( photos: [Photo] ) {
        self.photos = photos // Cache
        self.cellViewModels = photos.map{PhotoListCellViewModel(bsPhoto: $0)}
    }
    
}

// MARK: - User Actions
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
