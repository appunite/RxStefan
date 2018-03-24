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
        return base.didChangeStateObservable
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


fileprivate struct StefanAssociatedKeys {
    static var didChangeStateObservable: UInt8 = 0
}

extension StefanType {
    
    // Simulate behavior of a lazy var
    
    fileprivate var didChangeStateObservable: Observable<ItemsLoadableState<ItemType>> {
        get {
            guard let value = objc_getAssociatedObject(self, &StefanAssociatedKeys.didChangeStateObservable) as? Observable<ItemsLoadableState<ItemType>> else {
                
                let observable = createDidChangeStateObservable()
                objc_setAssociatedObject(self, &StefanAssociatedKeys.didChangeStateObservable, observable, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return observable
            }
            
            return value
        }
    }
    
    private func createDidChangeStateObservable() -> Observable<ItemsLoadableState<ItemType>> {
        return Observable.create({ observer in
            
            self.didChangeState = { newState in
                observer.onNext(newState)
            }
            
            return Disposables.create()
            
        }).share(replay: 1, scope: .whileConnected)
    }
}

