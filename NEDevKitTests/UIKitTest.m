//
//  UIKitTest.m
//  NEDevKit
//
//  Created by sddz_yuxiaohua on 15/10/14.
//
//

#import <XCTest/XCTest.h>

#import <UIKit/UIKit.h>
#import <NEDevKit/NEDevkit.h>

@interface UIKitTest : XCTestCase

@end

@implementation UIKitTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUIColor
{
    // can not run fluid
    // +[UIColor colorWithHexString:]: unrecognized selector sent to class 0x1048f1a30
    UIColor* hex_color = [UIColor colorWithHexString:@"#FFFFFF00"];
    XCTAssertNotNil(hex_color);
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
