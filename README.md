---
  tags: tutorial, beginner, OOP, Object-Oriented Programming, model 
  languages: objc
---

objc-Blocks
==============

Blocks are a fairly new addition to Objective-C, and have become a key feature in a multitude of Cocoa domain spaces.  Blocks provide an easy-to-use alternative to the delegation pattern in concurrent (multi-threaded) operations. They also allow for easy to read, in-line implementations of both synchronous and asynchronous callbacks.  

But what does this mean for me, you're likely asking.  It means, my friends, that the delegate based implementation of UIAlertView that looks like this: 

```objc

- (void)someMethod
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert Title" message:@"Message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        [self doSomething];
    }
    else if (buttonIndex == 1){
        [self doSomethingElse];
    }
}

```

Would look something like this (**if UIAlertView were implemented in blocks**): 

```objc 
- (void)someMethodWithBlocks
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert Title" message:@"Message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    alertView.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex){
        
        if (buttonIndex == 0){
            [self doSomething];
        }
        else if (buttonIndex == 1){
            [self doSomethingElse];
        }
    }
    
    [alertView show];
}

```

Blocks, often referred to as annonymous functions in other languages, allow for function-like behavior to be encapsulated in method parameters and variables.  In the AlertView example above, the UIAlertViewDelegate method `-alertView:clickedButtonAtIndex:` is replaced by a block property called 'tapBlock'.  'tapBlock' takes two parameters, an alertView and a buttonIndex, and just like the delegate method, calls back when a button in the alert view is clicked.

What's cool about this is, rather than implementing seperate methods to handle the likely simple behavior of reacting to a button press, we can implement the tapBlock from the same method in which we instantiated the AlertView.  This serves to make our code more readable and consise. In essence, we bundle the creation of the alert view with the call back behavior, relieving the effort of tracking down delegate method implementations.   


## Blocks come in many different shapes and sizes

Block syntax can be quite a mystery for beggining and expereienced Objective-C programmers alike.  In fact, there is an [entire website](http://goshdarnblocksyntax.com) dedicated to demystifying their formation.  Let's explore a few of the many ways to use blocks. (This list is lifted directly from goshdarnblocksyntax.com, with explanations added) 


##Local Variable

Abstraction: `returnType (^blockName)(parameterTypes) = ^returnType(parameters) {...};`
Example:
```objc

    //declare the block variable
    double(^farTempFromCelcTemp)(double celcTemp);
    
    //assign the block
    farTempFromCelcTemp = ^double(double celcTemp){
        
        return ((celcTemp * 1.8) + 32);
    };
    
    //call the block
    double myFarTemp = farTempFromCelcTemp(0); //returns 32.0
```

Explanation: This example shows a block being declared as a local variable. The block is then assigned a block function that implements converting a celcius temperature to farenheit. The block is then called and it's return value is assigned to a local variable.     

##Property

Abstraction: `@property (nonatomic, copy) returnType (^blockName)(parameterTypes);`
Example:

```objc

#import "FISAppDelegate.h"

@interface FISAppDelegate()

@property (nonatomic, copy) double(^farTempFromCelcTemp)(double celcTemp);

@end

@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    self.farTempFromCelcTemp = ^double(double celcTemp){
        return ((celcTemp *1.8) + 32);
    };

    double myFarTemp = self.farTempFromCelcTemp(0); 

    return YES;
}

```
Explanation: Blocks as properties are to blocks as local variables exactly what normal properties are to local variables.  They work exactly the same, except their scope is the entire class, they should be called using self, and they can be accessed or set from outside classes. 

##Method Parameter

Abstraction: `- (void)someMethodThatTakesABlock:(returnType (^)(parameterTypes))blockName;`
Example: 

```objc

- (void)getFriendsWithCompletion:(void (^)(NSArray *friends))completion{
	
	NSArray *myFriends = @[@"Joe", @"Avi", @"Logan", @"Victoria", @"Spencer", @"Adam"]; 

	completion(myFriends); // callBack to the block completion with an array of friends 
} 

```
Explanation: The method `-getFriendsWithCompletion:` takes the block `completion` as a paremeter.  

##Argument to a method call 
Abstraction: `[someObject someMethodThatTakesABlock: ^returnType (parameters) {...}];`
Example:
```objc
[self getFriendsWithCompletion:^(NSArray *friends) {
        NSLog(friends); // prints to the log `"Joe", "Avi", "Logan", "Victoria", "Spencer", "Adam"`
    }];
```
Explanation:
The method getFriendsWithCompletion: takes the block completion as an argument.  The implementation of the completion block assigns the myFriends array to the blocks array parameter.  Note that the block isn't returning anything in this case.  


##Typedef

Abstraction: `typedef returnType (^TypeName)(parameterTypes);
TypeName blockName = ^returnType(parameters) {...};`
Example:
Explanation:

__block modifier - 

Closures - 


##Resources

- [RyPress Blocks Tutorial](http://rypress.com/tutorials/objective-c/blocks.html)
- [Gosh Darn Block Syntax](http://goshdarnblocksyntax.com)
