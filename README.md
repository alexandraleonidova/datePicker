# Date Picker

Date Planning Assistant CS Mobile App Development (COMP 495 @ USD)

This application takes in user input regarding what kind of aspects they want in a date(an activity, a meal, nightlife) as well as interests within each of the aspets. A call to Yelp's API with this input is made to produce possible date locations. Then with the response, the application displays both a date with the shortest straightline distance and up to three other choices for each aspect of the date. The user then has the choice between choising the shortest date or individual aspects from the given choices. The chosen date details including location(map), name, rating, and price is then finally displayed to the user. 

## Getting Started

In your Xcode project, pull from `master`'.

Open terminal (`Command + Space`, then search for "terminal").

`cd` into the same directory as where your code for DatePicker is stored.

Install `CocoaPods` using the following commands:

```
sudo gem install cocoapods

pod setup

pod install
```

Wait for the installation to finish (might take several minutes), then quit Xcode.

Open DatePicker in Finder. In your DatePicker folder double click on the white `.xcworkspace` file to open the project (you'll have to use white icon from now on).

`Command + R` to build and run or press play button on the top left corner. Make sure you either connect your phone to Xcode or choose one of the simulator devices.

If you have any issues, please refer to the following [Stack Overflow post](https://stackoverflow.com/questions/20755044/how-to-install-cocoapods).
