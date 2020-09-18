//
//  PhotoListViewModelTests.swift
//  MVVM_Gallery_AppTests
//
//  Created by Victor Hugo Benitez Bosques on 9/17/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import XCTest
@testable import MVVM_Gallery_App

/*
 SUT : System Under Test
 */
class PhotoListViewModelTests: XCTestCase {

    var sut : PhotoListViewModel!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        
        // Test Enviroment API Service
        mockAPIService = MockApiService()  // Dummy Api Service
        sut = PhotoListViewModel(apiService: mockAPIService)
        super.setUp()
    }
    
    func test_fetch_photo_with_moking(){
        // we start fetch with Mocking Service
        sut.initFetch()
        assert(mockAPIService.isFetchPopularPhotoFromClienteCalled)
    
    }
    
    func test_fetch_photo_fail(){
        
        // Given a failed fetch with a certain failure
        let error = APIError.permissionDenied
        
        // When
        sut.initFetch()
        
        
        mockAPIService.fetchFail(error: error)
        
        // Sut (ViewModel) should display predefined error message
        XCTAssertEqual(sut.alertMessage, error.rawValue)
        
    }
    
    
    
    override func tearDown() {
        mockAPIService = nil
        sut = nil
        super.tearDown()
    }
}

/*
 Behavior Test
 First Use Case: The PhotoListViewModel should fetch data from the API Service
 We successfully test the behavior of our ViewModel
 
 Second Use Case: Succes or Failure networking states by Changing the response of the MockAPIService.
 We also want to see if the PhotoListViewModel correnctly handles networking states.
 
 */
// MARK: - Test Enviroment
class MockApiService : APIServiceProtocol{
    
    typealias MockinClosure = (Bool, [Photo], APIError?) -> ()
    
    var isFetchPopularPhotoFromClienteCalled : Bool = false
    
    var CompletePhotos : [Photo] = [Photo]()
    var completedClosure : (MockinClosure)?
    
    func fetchPopularPhoto(complete: @escaping MockinClosure) {
        isFetchPopularPhotoFromClienteCalled = true
        completedClosure = complete
    }
    
    
    func fetchFail(error : APIError){
        completedClosure?(false, CompletePhotos, error)
    }
    
    
    
}
