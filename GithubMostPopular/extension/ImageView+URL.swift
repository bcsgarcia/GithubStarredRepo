//
//  ImageView+URL.swift
//  GithubMostPopular
//
//  Created by Garcia, Bruno (B.C.) on 03/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage


let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingUrlString(urlString: String) {
        self.image = #imageLiteral(resourceName: "github")
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        Alamofire.request(urlString).responseImage { response in
            if let image = response.result.value {
                let imageToCache = image
                imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                self.image = imageToCache
            }
        }
    }
    
}
