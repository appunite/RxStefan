//
//  RxStefanTests.swift
//  RxStefanTests
//
//  Created by Szymon Mrozek on 22.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import XCTest
import Stefan_iOS
import RxSwift
@testable import RxStefan

fileprivate enum DummyError: Error {
    case dummy
}

class RxStefanTests: XCTestCase {
    
    let sut = Stefan<String>()
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    func testStateObservable() {
        
        let loadingExpectation = expectation(description: "Loading state")
        let noContentExpectation = expectation(description: "No content state")
        let errorExpectation = expectation(description: "Error state")
        let loadedExpectation = expectation(description: "Loaded state")
        
        sut.rx.stateObservable
            .subscribe(onNext: { newState in
                switch newState {
                case .loading:
                    loadingExpectation.fulfill()
                case .noContent:
                    noContentExpectation.fulfill()
                case .error:
                    errorExpectation.fulfill()
                case .loaded:
                    loadedExpectation.fulfill()
                default:
                    break
                }
            }).disposed(by: disposeBag)
        
        sut.load(newState: .loading)
        sut.load(newState: .noContent)
        sut.load(newState: .error(DummyError.dummy))
        sut.load(newState: .loaded(items: ["Test", "Target"]))
        
        wait(for: [loadingExpectation, noContentExpectation, errorExpectation, loadedExpectation], timeout: 1.0)
    }
    
    func testStateBinder() {
        
        let loadingExpectation = expectation(description: "Loading state")
        let noContentExpectation = expectation(description: "No content state")
        let errorExpectation = expectation(description: "Error state")
        let loadedExpectation = expectation(description: "Loaded state")
        
        sut.rx.stateObservable
            .subscribe(onNext: { newState in
                switch newState {
                case .loading:
                    loadingExpectation.fulfill()
                case .noContent:
                    noContentExpectation.fulfill()
                case .error:
                    errorExpectation.fulfill()
                case .loaded:
                    loadedExpectation.fulfill()
                default:
                    break
                }
            }).disposed(by: disposeBag)
        
        let signal = Observable<ItemsLoadableState<String>>.create({ observer in
            observer.onNext(ItemsLoadableState.loading)
            observer.onNext(ItemsLoadableState.noContent)
            observer.onNext(ItemsLoadableState.error(DummyError.dummy))
            observer.onNext(ItemsLoadableState.loaded(items: ["Test", "Target"]))
            
            return Disposables.create()
        })
        
        signal.bind(to: sut.rx.loader).disposed(by: disposeBag)
        
        wait(for: [loadingExpectation, noContentExpectation, errorExpectation, loadedExpectation], timeout: 1.0)
    }
    
    func testStateSafeBinder() {
        
        let loadingExpectation = expectation(description: "Loading state")
        
        let firstLoadedExpectation = expectation(description: "Loaded state")
        let firstLoadedItems = ["Test", "Target"]
        
        let secondLoadedExpectation = expectation(description: "Secondary loaded state - just to verify that error did not occur")
        let secondLoadedItems = ["Test", "Target", "Another"]
        
        sut.rx.stateObservable
            .subscribe(onNext: { newState in
                switch newState {
                case .loading:
                    loadingExpectation.fulfill()
                case .error:
                    XCTFail("Error state should not be loaded after loaded state")
                case .loaded(let items):
                    if items == firstLoadedItems {
                        firstLoadedExpectation.fulfill()
                    } else if items == secondLoadedItems {
                        secondLoadedExpectation.fulfill()
                    }
                default:
                    break
                }
            }).disposed(by: disposeBag)
        
        let signal = Observable<ItemsLoadableState<String>>.create({ observer in
            observer.onNext(ItemsLoadableState.loading)
            observer.onNext(ItemsLoadableState.loaded(items: firstLoadedItems))
            observer.onNext(ItemsLoadableState.error(DummyError.dummy))
            observer.onNext(ItemsLoadableState.loaded(items: secondLoadedItems))
            
            return Disposables.create()
        })
        
        signal.bind(to: sut.rx.safeLoader).disposed(by: disposeBag)
        
        wait(for: [loadingExpectation, firstLoadedExpectation, secondLoadedExpectation], timeout: 1.0)
    }
}

