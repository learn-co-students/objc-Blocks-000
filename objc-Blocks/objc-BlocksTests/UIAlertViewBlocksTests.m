//
//  UIAlertViewBlocksTests.m
//  objc-Blocks
//
//  Created by Al Tyus on 4/30/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "Specta.h"

#define EXP_SHORTHAND

#import "Expecta.h"
#import "UIAlertViewBlocks.h"

SpecBegin(UIAlertViewBlocksTests)

                describe(@"UIAlertViewBlocksTests", ^{

                    __block UIAlertViewBlocks *alertViewBlocks;
                    beforeAll(^{

                        alertViewBlocks = [[UIAlertViewBlocks alloc] initWithTitle:@"Title" message:@"Message" cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK" tapBlock:^(UIAlertView *view, NSInteger i) {

                        } shouldEnableBlock:^BOOL(UIAlertView *view) {
                            return YES;
                        } willPresentBlock:^(UIAlertView *view) {

                        } didPresentBlock:^(UIAlertView *view) {

                        } willDismissBlock:^(UIAlertView *view, NSInteger i) {

                        } didDismissBlock:^(UIAlertView *view, NSInteger i) {

                        } cancelBlock:^(UIAlertView *view) {

                        }];
                    });

                    beforeEach(^{
                    });

                    it(@"should conform to UIAlertViewDelegate Protocol", ^{
                        expect([UIAlertViewBlocks class]).to.conformTo(@protocol(UIAlertViewDelegate));
                    });

                    it(@"should allow initialization with tapBlock", ^{
                        expect([UIAlertViewBlocks alloc]).to.respondTo(@selector(initWithTitle:message:cancelButtonTitle:otherButtonTitles:tapBlock:));
                    });

                    it(@"should allow initialization with designated initiatlizer", ^{
                        expect([UIAlertViewBlocks alloc]).to.respondTo(@selector(initWithTitle:message:cancelButtonTitle:otherButtonTitles:tapBlock:shouldEnableBlock:willPresentBlock:didPresentBlock:willDismissBlock:didDismissBlock:cancelBlock:));
                    });

                    it(@"should have a tapBlock property", ^{
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(tapBlock));
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(setTapBlock:));
                        expect(alertViewBlocks.tapBlock).to.beKindOf(NSClassFromString(@"NSBlock"));
                    });

                    it(@"should have a shouldEnableFirstOtherButtonBlock property", ^{
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(shouldEnableFirstOtherButtonBlock));
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(setShouldEnableFirstOtherButtonBlock:));
                        expect(alertViewBlocks.shouldEnableFirstOtherButtonBlock).to.beKindOf(NSClassFromString(@"NSBlock"));
                    });

                    it(@"should have a willPresentBlock property", ^{
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(willPresentBlock));
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(setWillPresentBlock:));
                        expect(alertViewBlocks.willPresentBlock).to.beKindOf(NSClassFromString(@"NSBlock"));
                    });

                    it(@"should have a didPresentBlock property", ^{
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(didPresentBlock));
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(setDidPresentBlock:));
                        expect(alertViewBlocks.didPresentBlock).to.beKindOf(NSClassFromString(@"NSBlock"));
                    });

                    it(@"should have a willDismissBlock property", ^{
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(willDismissBlock));
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(setWillDismissBlock:));
                        expect(alertViewBlocks.willDismissBlock).to.beKindOf(NSClassFromString(@"NSBlock"));
                    });

                    it(@"should have a didDismissBlock property", ^{
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(didDismissBlock));
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(setDidDismissBlock:));
                        expect(alertViewBlocks.didDismissBlock).to.beKindOf(NSClassFromString(@"NSBlock"));
                    });

                    it(@"should have a cancelBlock property", ^{
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(cancelBlock));
                        expect([UIAlertViewBlocks new]).to.respondTo(@selector(setCancelBlock:));
                        expect(alertViewBlocks.cancelBlock).to.beKindOf(NSClassFromString(@"NSBlock"));
                    });


                    it(@"should implement clickedButtonAtIndex", ^{
                        expect(alertViewBlocks).to.respondTo(@selector(alertView:clickedButtonAtIndex:));
                    });

                    it(@"should implement alertViewShouldEnableFirstOtherButton", ^{
                        expect(alertViewBlocks).to.respondTo(@selector(alertViewShouldEnableFirstOtherButton:));
                    });

                    it(@"should implement willPresentAlertView", ^{
                        expect(alertViewBlocks).to.respondTo(@selector(willPresentAlertView:));
                    });
                    it(@"should implement didPresentAlertView", ^{
                        expect(alertViewBlocks).to.respondTo(@selector(didPresentAlertView:));
                    });
                    it(@"should implement alertViewWillDismissWithButtonIndex", ^{
                        expect(alertViewBlocks).to.respondTo(@selector(alertView:willDismissWithButtonIndex:));
                    });
                    it(@"should implement alertViewDidDismissWithButtonIndex", ^{
                        expect(alertViewBlocks).to.respondTo(@selector(alertView:didDismissWithButtonIndex:));
                    });
                    it(@"should implement alertViewCancel", ^{
                        expect(alertViewBlocks).to.respondTo(@selector(alertViewCancel:));
                    });

                    afterEach(^{
                    });
                    afterAll(^{
                    });

                });

                SpecEnd
