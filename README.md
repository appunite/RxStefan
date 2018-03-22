<p align="center">
  <img src="resources/stefan_logo.png" alt="Stefan logo"/>
</p>

# RxStefan

> This repo is only about **RxSwift** extensions for **Stefan** library. Please follow [Stefan repo](https://github.com/appunite/Stefan) for general **Stefan** issues.

## Example usage 

```swift
dataSignal                        
    .mapToLoadableState()        // signal of some collection, i.e. Observable<Response<[Fruit]>>
    .bind(to: stefan.rx.loader)  // your mapping function that transforms response into ItemsLoadableState
    .disposed(by: disposeBag)    // binding extension from this library
```

And that's that! So simple to bind your response of items into stefan :) 

You can also observe states changing 

```swift
stefan.rx.stateObservable
	.subscribe(onNext: { [weak self] (state) in

    	// most recent state 
    	...

	}).disposed(by: disposeBag)
```

### Carthage

Add the following entry in your Cartfile:

```
github "appunite/RxStefan"
```

> There is no need to have `github "appunite/RxStefan"` in Cartfile.

Then run `carthage update`.

### Contribution

Project is created and maintened by **Piotr Bernad** and **Szymon Mrozek**.

We could use your help with reporting or fixing bugs. We would also like to hear from you about feature suggestions. If you have an idea how to make Stefan better you are welcome to send us a Pull Request.

### License

RxStefan is released under an MIT license. See [License.md](LICENSE.md) for more information.