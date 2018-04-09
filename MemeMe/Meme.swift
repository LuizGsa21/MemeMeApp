//
// Created by Luiz Arantes Sa on 4/9/18.
// Copyright (c) 2018 Luiz Arantes Sa. All rights reserved.
//

import UIKit

struct Meme {
    var topText: String;
    var bottomText: String;
    var originalImage: UIImage;

    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: Any) {
        self.topText = topText;
        self.bottomText = bottomText;
        self.originalImage = originalImage;
    }
}
