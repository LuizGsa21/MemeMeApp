//
//  NSObjectProtocol+Extension.swift
//  MemeMe2
//
//  Created by Luiz Arantes Sa on 3/30/19.
//  Copyright © 2019 Luiz Arantes Sa. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    
    static var className: String {
        return String(describing: Self.self)
    }
}
