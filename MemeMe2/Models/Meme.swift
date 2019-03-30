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
    
    static var allMemes: [Meme] = [

        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "trevelyan")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "Goldfinger")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "Zorin")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "blofeld")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "jaws")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "lechiffre")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "oddjob")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "klebb")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "silva")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "big")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "drax")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "scaramanga")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "oddjob")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "trevelyan")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "Goldfinger")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "Zorin")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "blofeld")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "jaws")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "lechiffre")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "oddjob")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "klebb")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "silva")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "big")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "drax")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "scaramanga")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "oddjob")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "trevelyan")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "Goldfinger")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "Zorin")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "blofeld")!),
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "trevelyan")!, memedImage: UIImage(named: "jaws")!)
    ]

}
