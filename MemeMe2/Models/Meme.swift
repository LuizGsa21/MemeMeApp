//
//  Meme.swift
//  MemeMe2
//
//  Created by Luiz Arantes Sa on 3/30/19.
//  Copyright © 2019 Luiz Arantes Sa. All rights reserved.
//

import UIKit

struct Meme {
    let topText: String;
    let bottomText: String;
    let originalImage: UIImage;
    let memedImage: UIImage;
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText;
        self.bottomText = bottomText;
        self.originalImage = originalImage;
        self.memedImage = memedImage;
    }
}


extension Meme {
    
    static var allMemes: [Meme] = []

}
