//
//  Array+Only.swift
//  Memorize
//
//  Created by Andre Jardim Firmo on 06/08/20.
//  Copyright © 2020 Andre Jardim Firmo. All rights reserved.
//

import Foundation

extension Array {
    var only : Element? {
        count == 1 ? first : nil
    }
    
}
