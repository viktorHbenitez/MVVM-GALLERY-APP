# MVVM GALLERY APP

## Description: 

1. The app fetch popular photos from 500px API and lists photo in a UITableView.  
2. Each cell in the table view shows a title, a description and the created data of a photo.  
3. User are not allowed to click photo which are not labeled for_sale .  

## Steps to Split ViewController to ViewModel
1. Design  a set of interfaces for binding
2. Move the presentational logic and controller logic to ViewModel

### 1. Let's take a look at the UI components in the View: 

1. Activity Indicator (Start Loading / End Loading )
2. TableView(Show / Hide)
3. Cell (title, description, created date)

ViewModel flow

1. ViewModel starts to fetch data
2. After the data fetch, we create PhotoListCellViewModel objects and update the cellViewModel
3. The View is notified of the update and then  layouts cells using the updated cellViewModel


### Flow of the ViewModel
![Flow Diagram](https://github.com/viktorHbenitez//MVVM-GALLERY-APP/blob/master/Sketch/flow.png)  

### Gallery App
![Version App](https://github.com/viktorHbenitez/MVVM-GALLERY-APP/blob/master/Sketch/GalleryApp.jpg)  

## Unit Testing

We will cover to techniques:
How to design a mock to simulate different network states
How to use stubs to test user interaction


Reference  [Gallery App ](https://medium.com/flawless-app-stories/how-to-use-a-model-view-viewmodel-architecture-for-ios-46963c67be1b/)
Reference  [Unit Testing](https://medium.com/flawless-app-stories/applying-unit-tests-to-mvvm-with-swift-ba5a79df8a18)
