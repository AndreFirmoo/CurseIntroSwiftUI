//
//  Array+identifiable.swift
//  Memorize
//
//  Created by Andre Jardim Firmo on 05/08/20.
//  Copyright © 2020 Andre Jardim Firmo. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func fistIndex(matching: Element) -> Int? {
        for index in 0 ..< self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil 
    }
}
