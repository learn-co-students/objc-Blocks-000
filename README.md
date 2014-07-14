---
  tags: blocks
  languages: objc
---

objc-Blocks
==============

Blocks are a fairly new addition to Objective-C, and have quickly become a staple in iOS frameworks.  Blocks provide an easy-to-use alternative to the delegation pattern in concurrent (multi-threaded) operations.

Often referred to as anonymous functions, closures, or lambdas in other languages, blocks allow for function-like behavior to be encapsulated in method parameters and variables.  

##Instructions

Your challenge should you choose to except it, is to implement `UIAlertView` using blocks instead of delegates.  

- Your implementation should be put into a subclass of `UIAlertView` called `UIAlertViewBlocks`
- Each `UIAlertView` Delegate method should be supplemented with a block property.  For example, instead of calling `-alertView:clickedButtonAtIndex:` a user of your class will call the block tapBlock. Note that the method signature of your blocks, should be the same as the method signature of the delegate method.

**Delegate**`– alertView:clickedButtonAtIndex:` = **Block** `^tapBlock`

**Delegate**`– alertViewShouldEnableFirstOtherButton:` = **Block** `^ShouldEnableFirstOtherButtonBlock`

**Delegate**`– willPresentAlertView:` = **Block** `^willPresentBlock`

**Delegate**`– didPresentAlertView:` = **Block** `^didPresentBlock`

**Delegate**`– alertView:willDismissWithButtonIndex:` = **Block** `^willDismissBlock`

**Delegate**`– alertView:didDismissWithButtonIndex:` = **Block** `^didDismissBlock`

**Delegate**`– alertViewCancel:` = **Block** `^cancelBlock`

- AlertViewBlocks should have two initializers:

```objc
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles
                     tapBlock:(TapBlock)tapBlock;
```
and
```objc
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles
                     tapBlock:(TapBlock)tapBlock
            shouldEnableBlock:(ShouldEnableBlock)shouldEnableFirstOtherButtonBlock
             willPresentBlock:(AlertBlock)willPresentBlock
              didPresentBlock:(AlertBlock)didPresentBlock
             willDismissBlock:(TapBlock)willDismissBlock
              didDismissBlock:(TapBlock)didDismissBlock
                  cancelBlock:(AlertBlock)cancelBlock;
```

**TapBlock, ShouldEnableBlock and AlertBlock are typedefs that describe the blocks used in each method parameter.**

```objc

UIAlertViewBlocks *alertView = [[UIAlertViewBlocks alloc] initWithTitle:@"title"
                                                                    message:@"message"
                                                          cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK"
                                                                   tapBlock:^(UIAlertView *view, NSInteger i) {
                                                                       NSLog(@"%d", i); // should print the index of the tapped button
                                                                   }];
[alertView show];

```

Examples
============

Blocks come in many different shapes and sizes

Block syntax can be quite a mystery for beginning and experienced Objective-C programmers alike.  In fact, there is an [entire website](http://goshdarnblocksyntax.com) dedicated to demystifying their formation.  Let's explore a few of the many ways to use blocks. (This list is lifted directly from goshdarnblocksyntax.com, with explanations added)


###Local Variable

**Abstraction:** `returnType (^blockName)(parameterTypes) = ^returnType(parameters) {...};`
**Example:**
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

**Explanation:** This example shows a block being declared as a local variable. The block is then assigned a block function that implements converting a Celsius temperature to Fahrenheit. The block is then called and it's return value is assigned to a local variable.

###Property

**Abstraction:** `@property (nonatomic, copy) returnType (^blockName)(parameterTypes);`
**Example:**

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

**Explanation:** Comparing 'Blocks as Properties' to 'Blocks as Local Variables' parallels comparing properties to local variables.  Blocks as properties work exactly the same as blocks as local variables but their scope is the entire class rather than a single method, they should be called using self, and they can be accessed or set from outside classes.

###Method Parameter

**Abstraction:** `- (void)someMethodThatTakesABlock:(returnType (^)(parameterTypes))blockName;`
**Example:**

```objc

- (void)getFriendsWithCompletion:(void (^)(NSArray *friends))completion{

	NSArray *myFriends = @[@"Joe", @"Avi", @"Logan", @"Victoria", @"Spencer", @"Adam"];

	completion(myFriends); // callBack to the block completion with an array of friends
}

```
**Explanation:** The method `-getFriendsWithCompletion:` takes the block `completion` as a parameter.  

###Argument to a method call
**Abstraction:** `[someObject someMethodThatTakesABlock: ^returnType (parameters) {...}];`
**Example:**
```objc
[self getFriendsWithCompletion:^(NSArray *friends) {
        NSLog(friends); // prints to the log `"Joe", "Avi", "Logan", "Victoria", "Spencer", "Adam"`
    }];
```
**Explanation:**
The method `getFriendsWithCompletion:` takes the block completion as an argument.  The implementation of the completion block assigns the `myFriends` array to the blocks array parameter.  Note that the block isn't returning anything in this case.  


###Typedef

**Abstraction:** `typedef returnType (^TypeName)(parameterTypes);
TypeName blockName = ^returnType(parameters) {...};`
**Example:**

```objc
@interface FISAppDelegate ()

typedef double(^farTempFromCelcTempBlock)(double); //create type definition for block

@end

...

//@implementaiton

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    farTempFromCelcTempBlock farTempBlock; //declare a local variable using the type declared in typedef
    farTempFromCelcTempBlock farTempBlock = ^double(double celcTemp){
        return ((celcTemp *1.8 + 32));
    }; // implement farTempBlock

    double myTypeDefTemp = farTempBlock(0); //returns 32

    ...
}
```

###Resources

- [RyPress Blocks Tutorial](http://rypress.com/tutorials/objective-c/blocks.html)
- [Gosh Darn Block Syntax](http://goshdarnblocksyntax.com)
