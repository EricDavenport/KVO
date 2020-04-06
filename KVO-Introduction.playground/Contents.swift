import UIKit

// KVO - Key-Value observoing

// KVO is an observer pattern
// NotificationCenter is also an observer pattern

// KVO is a one-to-one many pttern relationship as opposed to delegation whic is a one-to-one

// In the delegation pattern
//  class ViewController : UIViewController {{}
//  e.g tableView.dataSOurce = self

// KVO is an objective-C runtime API
// Along with KVO being an objective-C runtime some essentials are required
//  1. The object being observed needs to be a class
//  2. The class needs to inherit from NSObject, NSObject is the top abstract class in Objective-C. The class also needs to be marked @objc
//  3. Any property being marked for observation needs to be prefixed with @objc dynamic.
//                Dynamic mean the property is being dynamically dispatched - (at runtime the compiller verifies the underlying property)
//    In swift - types are statically dispatched which means they are checked at compiller time vs Objective-C which is dynaminally dispatched and checked at runtime

// Static vs Dynamic dispatch

// https://medium.com/flawless-app-stories/static-vs-dynamic-dispatch-in-swift-a-decisive-choice-cece1e872d


// Dog class (Class being observed) - will have a property to be observed
@objc class Dog: NSObject {         // Dog is KVO-compliant
  var name : String
  @objc dynamic var age : Int               // age is observable property
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
  
  
}


// Observer class one  -- app wise - clas == viewcontroller
class DogWalker {
  let dog : Dog
//  similar to listener registeration in firebase
  var birthdayObservation : NSKeyValueObservation?      // handle - i.e age on the (let dog : Dog )
//  e.g listenerRegistration : ListenerRegistration?
  init(dog: Dog) {
//  \.dog is keyPath syntax for KVO
    self.dog = dog
    configureBirthdayObservation()
  }
  
  
  private func configureBirthdayObservation() {
//  \.age is keyPath syntax for KVO observing
    birthdayObservation = dog.observe(\.age, options: [.old, .new], changeHandler: { (dog, change) in
// update UI of the app accordingly if in a ViewController class
      guard let age = change.newValue else { return }
      guard let oldAge = change.oldValue else { return }
      print("Hey \(dog.name), happy \(age) birthday from the dog walker")
      print("dogWalker oldValue: \(oldAge)")
      print("dogWalker newValue: \(age)\n")
    })
  }
}


// Observer class two
class DogGroomer {
  let dog: Dog
  var birthdayObvervation: NSKeyValueObservation?
  
  init(dog: Dog) {
    self.dog = dog
    configureBirthdayObservation()
  }
  
  private func configureBirthdayObservation() {
    birthdayObvervation = dog.observe(\.age, options: [.old, .new], changeHandler: { (dog, change) in
      guard let age = change.newValue else { return }
      print("Hey \(dog.name), happy \(age) birthday from the dog groomer")
      print("dogGroomer oldValue: \(change.oldValue ?? 0)")
      print("dogGroomer newValue: \(change.newValue ?? 0)\n")
    })
  }
}

// test out KVO observing on the .age property
// both classes (DogWalker and DogGroomer should get .age changes)

let snoopy = Dog(name: "Snoopy", age: 5)
// both dogWalker and DogGroomer have a reference on snoopy
let dogGroomer = DogGroomer(dog: snoopy)
let dogWalker = DogWalker(dog: snoopy)

snoopy.age += 1 // increment from 5 to 6



// notes for self
/*
 @objc for class
 @objc dynamic for observed property
 
 handle - variable created to observe the change
 NSKeyValueObservation - similar to listener in firebase
 function for observation - object.observe - options selection
        \.(property being observed)
 
 */

// notes for app making
/*
 class = the view controller
 update ui in configureObserverFuntion completion handler
 
 
 */



