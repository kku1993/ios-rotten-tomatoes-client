ios-rotten-tomatoes-client
==========================

A simple iOS client for Rotten Tomatoes.

Total Time Spent: 8 hours

Completed User Stories:

- User can view a list of movies from Rotten Tomatoes.  Poster images must be loading asynchronously.
- User can view movie details by tapping on a cell.
- User sees loading state while waiting for movies API. 
- User sees error message when there's a networking error. 
- User can pull to refresh the movie list.
- Add a tab bar for Box Office and DVD. (optional)

# Installation
- Clone the project
- Install dependencies using CocoaPods

  `` pod install ``
    
- Modify ``RottenTomatoesClient/config.template.plist`` by inserting your own Rotten Tomatoes API key and renaming the file to ``config.plist``.

# Walkthrough
![Video Walkthrough](https://raw.githubusercontent.com/kku1993/ios-rotten-tomatoes-client/walkthroughs/walkthrough.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

# Libraries Used
- [AFNetworking](http://afnetworking.com/)
- [MMProgressHUD](https://github.com/mutualmobile/MMProgressHUD)

# Icons
- [Icons8](http://icons8.com)
