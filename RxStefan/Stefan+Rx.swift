//
//  Stefan+Rx.swift
//  RxStefan
//
//  Created by Szymon Mrozek on 22.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Stefan_iOS

extension Reactive where Base: StefanType, Base: NSObject {
    
    /// Stefan.state via reactive signal
    
    public var stateObservable: Observable<ItemsLoadableState<Base.ItemType>> {
        
        return Observable.create({ observer in
            
            self.base.didChangeState = { newState in
                observer.onNext(newState)
            }
            
            return Disposables.create()
            
        }).share(replay: 1, scope: .whileConnected)
    }
    
    /// Bindable sink for `load(newState ...)` function.
    
    public var loader: Binder<ItemsLoadableState<Base.ItemType>> {
        return Binder(self.base) { stefan, newState in
            stefan.load(newState: newState)
        }
    }
    
    /// Bindable sink for `load(newState ...)` function in soft version.
    /// do not clear loaded items if error occured

    public var safeLoader: Binder<ItemsLoadableState<Base.ItemType>> {
        return Binder(self.base) { stefan, newState in
            if case .error = newState, case .loaded = stefan.state {
                return
            } else {
                stefan.load(newState: newState)
            }
        }
    }
}
