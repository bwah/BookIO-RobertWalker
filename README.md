# BookIO-RobertWalker

---

## To download and run the project in your iOS simulator:

1. Ensure xcode is installed

This project was built with Xcode 15 and has a minimum deployment target of iOS 16

2. Clone project

"git clone {repo url}"

3. Start local server

Install nodejs if needed, open BookIO-Server and npm run dev

cd BookIO-Server; npm run dev

4. Open xcodeproj in Xcode

found at BookIO-iOS/BookIO.xcodeproj

5. Select an iPhone simulator with iOS 16/17 and choose Product->Run (or tap play button)

---

## Users

When running with the server built into this repo, you can use a pre-created user with the credentials testuser/test

To create a new user, select "Create New Account" from the login screen

To logout of a user account, tap the profile icon at the top right of the books list and select "Logout" from the action menu

## Functionality

To see the details of a book, tap the book row from the main list; this should navigate to the book detail view

To favorite a book, navigate to the detail view of a book in the main list; tap the "Make Favorite" button

The favorite book should show at the top of the book list along with a "FAVORITE" label

