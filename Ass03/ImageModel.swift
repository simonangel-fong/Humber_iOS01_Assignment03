//
//  ImageModel.swift
//  Ass03
//
//  Created by Simon Fong on 15/11/2023.
//

import Foundation
///
/// A class to represent an image
class Image{
    /// The title of this image
    var title:String
    /// The url of this image
    var url:String
    
    /// Initial function
    init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}

/// A class to represent a model objects
class ImageModel{
    /// A list of image objects
    var imgList: [Image]
    
    ///Initiate functions
    init() {
        /// By default, the list is an empty list.
        self.imgList = [Image]()
        /// init data for testing
        //        imgList = [
        //            Image(title: "Toronto", url: "https://www.toronto.ca/wp-content/uploads/2023/11/90cf-hometorontoskylinefall-1500x700.jpg"),
        //            Image(title: "night", url: "https://www.toronto.ca/wp-content/uploads/2017/07/8e31-explore-visitor-banner.jpg"),
        //        ]
    }
    
    /// Get Image object based on the index
    func getImgByIndex(index:Int) -> Image {
        return imgList[index]
    }
    
    /// Add new Image object
    func addNewImg(newImage: Image) -> Bool{
        self.imgList.append(newImage)
        return true
    }
    
    /// Get the number of image objects.
    func count() -> Int{
        return imgList.count
    }
}
