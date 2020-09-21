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
    
    func test_fetch_popular_photo_with_moking(){
        // we start fetch with Mocking Service
        sut.initFetch()
        
        assert(mockAPIService.isFetchPopularPhotoFromClienteCalled)
    }
    
     // USE CASE: ViewModel should display an error message if the request failed
    func test_fetch_popular_photo_status_networking_fail(){
        
        // 1. Given a failed fetch with a certain failure
        let error = APIError.permissionDenied
        
        // 2. When
        sut.initFetch()
        
        mockAPIService.fetchFail(error: error)
        
        // SUT (ViewModel) should display predefined error message
        XCTAssertEqual(sut.alertMessage, error.rawValue)
    }
    
    
    /*
       Use Case: Closure loading response when the store property  locading change
       1. loading is false
       2. Loading is true when the method service is called
       3. Invoke  update loading status
       4. Loading is false when the closure is invoked, it is already completed
       */
    func test_response_loading_when_fetching(){
        
        // GIVE A PREDICTION
        var loadingStatus = false
        
        // Create expectation : you tell method test, you want to wait for a while before proceeding
        let expectation = XCTestExpectation(description: "loading status updated")
    
        //  Change stats of loading variable
        sut.updateLoadingStatus = { [weak sut] in
            loadingStatus = sut!.isLoading
            
            // When it is finished, mark my expectation as being fulfilled, mark is  as completed
            expectation.fulfill()
        }
        
        // When is ViewModel run service client
        sut.initFetch()
        
        // Assert is true
        XCTAssertTrue(loadingStatus)
        
        // Change again to false
        mockAPIService.fetchSuccess()
        
        //  Wait one second for all aoutstanding expectations to ve fulfilled
        wait(for: [expectation], timeout: 1.0)
        
        // Assert return to false
        XCTAssertFalse(loadingStatus)
        
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
 
 Second Use Case: Success or Failure networking states by Changing the response of the MockAPIService.
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
    
    
    func fetchSuccess(){
        completedClosure?(true, CompletePhotos, nil)
    }
    
    
}
