//
// Created by Luiz Arantes Sa on 2019-03-30.
// Copyright (c) 2019 Luiz Arantes Sa. All rights reserved.
//

import UIKit


class MemeTableViewCell : UITableViewCell {

    override func layoutSubviews() {
        self.imageView!.frame.size = CGSize(width: 150, height: 150)
        let padding: CGFloat = 8
        self.textLabel!.frame = CGRect(x:self.imageView!.frame.maxX + padding, y:0, width: self.bounds.width - 150 - padding * 2, height: 150)
    }
}
