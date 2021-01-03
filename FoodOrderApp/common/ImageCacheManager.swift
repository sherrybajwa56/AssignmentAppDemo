//
//  ImageCacheManager.swift
//  FoodOrderApp
//
//  Created by Sherry on 12/12/20.
//

import Foundation
import UIKit
class ImageCacheManager {
    private static let cache: NSCache<AnyObject, AnyObject>  = NSCache()
    static func getImage(serverPath: String) -> UIImage? {
        let hash = serverPath.hash
        return cache.object(forKey: hash as AnyObject) as? UIImage
    }
    static func saveImage(serverPath: String, image: UIImage?) {
        guard let image = image else {
            return
        }
        let hash = serverPath.hash
        cache.setObject(image, forKey: hash as AnyObject)
    }
    static func clearCache(){
        cache.removeAllObjects()
    }
}
