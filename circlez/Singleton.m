//
//  Singleton.m
//  Circlez
//
//  Created by GParvaneh on 09/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"


@implementation Singleton

@synthesize currentCircle;
@synthesize clickedCircle;
@synthesize currentLevel;
@synthesize totalCirclez;

@synthesize isAuthenticated;
@synthesize userId;

+ (Singleton*) sharedGameStateInstance {
	
	static Singleton *sharedGameStateInstance;
	
	@synchronized(self){
		if(!sharedGameStateInstance){
			sharedGameStateInstance = [[Singleton alloc] init];
			sharedGameStateInstance.currentCircle = 0;
			sharedGameStateInstance.clickedCircle = 0;
			sharedGameStateInstance.currentLevel = 1;
			sharedGameStateInstance.totalCirclez = 0;
			
			sharedGameStateInstance.isAuthenticated = NO;
		}
	}
	
	return sharedGameStateInstance;
}

- (void)dealloc {
	[super dealloc];
}

@end

