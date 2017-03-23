//
//  Extensions.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func rgbAlpha(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func navigationBar() -> UIColor{
        return UIColor.rgb(red: 52, green: 34, blue: 20)
    }
}

extension UIView{
    
    func addConstraintWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
            
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


extension UIImage{
    func resize(newWidth : CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView : UIImageView{
    
    var imageUrlString : String?
    func loadImageUsingUrlString(urlString: String){
        
        imageUrlString = urlString
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            image = imageFromCache
            return
        }
        var mUrlString = urlString
        mUrlString = mUrlString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        if let url = URL(string: mUrlString){
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error!)
                }
                else{
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: data!)
                        if self.imageUrlString == urlString{
                            self.image = imageToCache
                        }
                        if imageToCache != nil{
                            imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                        }
                        else{
//                            self.image = UIImage(named: "no_image_icon")
                        }
                    }
                }
                
                
            }).resume()
        }else{
//            self.image = UIImage(named: "no_image_icon")
        }
    }
}
