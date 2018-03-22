//
//  StefanType.swift
//  RxStefan
//
//  Created by Szymon Mrozek on 22.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation
import Stefan_iOS

public protocol StefanType: class {
    
    associatedtype ItemType: Equatable
    
    var state: ItemsLoadableState<ItemType> { get }
    var didChangeState: ((ItemsLoadableState<ItemType>) -> Void) { get set }
    
    func load(newState: ItemsLoadableState<ItemType>)
}

extension Stefan: StefanType {
    
}
