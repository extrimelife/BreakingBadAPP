//
//  ImageCatchManager.swift
//  BreakingBadApp
//
//  Created by roman Khilchenko on 02.12.2022.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
