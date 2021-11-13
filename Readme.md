

Hello, this is an app created for finding information about Marvel, such as comics, events and characters. the app can also track comic that you have acquired or want to acquire.

Link for cloning the project:
`https://github.com/renan-baialuna/MarvelTraker.git`

This application is develop in Xcode 12.5 and Swift 5

to start the project, please open the project ("MarvelTraker.xcodeproj" in the downloded folder) with xcode and press "Run" in the top section of the left side.

# About the app

The main form of navigation is using the navigation controller

## Search screen

The initial screen is design for initiating search or accessing the part about inventory or wishlist. In it, you can start a search using the textField placing the begining of a name for search in diferent categorys. There is also a field indicating the last search done in a button that changes the textField to the last search.

## Results Screens

The Screen resulting the search are the results of comics, events and caracters. Each brings some detail about the screen and when selected (collection for caracters and comics, and table for events). The user can select a cell for viewing in more details about the select item.

## Details Screens

The detail screen brings more info from the api about the comic, event or caracter. 
On the comic details the user has the option to bring more details, add it to a wishList or to acquisition. When adding it to the inventory, the user is conducted to an adition screen (such as condition and value).

## WhishList Screens

In the wishlist screen, the user can see a list of comic on the wish and select for seing more details about the comic, exclude it from the list or add it to the inventory (throw the addition screen, for adding more details about the comic).

## Inventory Screens

In the Inventory list, the user can see all comic saved, see details and edit some conditions about the comic (or remove it). 
The data form wishList and inventory (including images) is store locally, so the user can access it with no internet.

## Image Screen

There is a screen for visualization of images that can be access from multiple points of the app.
