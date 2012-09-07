//
//  Singleton.h
//  Circlez
//
//  Created by GParvaneh on 09/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Singleton : NSObject {
	
	NSInteger currentCircle;
	NSInteger clickedCircle;
	NSInteger currentLevel;
	NSInteger totalCirclez;
	
	BOOL isAuthenticated;
	NSString *userId;
	
}

@property (nonatomic, assign) NSInteger currentCircle;
@property (nonatomic, assign) NSInteger clickedCircle;
@property (nonatomic, assign) NSInteger currentLevel;
@property (nonatomic, assign) NSInteger totalCirclez;

@property (nonatomic, assign) BOOL isAuthenticated;
@property (nonatomic, assign) NSString *userId;

+ (Singleton*) sharedGameStateInstance;

@end
