//
//  Circle.m
//  Circlez
//
//  Created by GParvaneh on 09/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Circle.h"
#import "HelloWorldScene.h"


@implementation Circle

- (CGRect)rect
{
	//CCLOG(@"SIZE: %0.2f x %0.2f", self.contentSize.width * self.scale, self.contentSize.height * self.scale);
	return CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
}

- (void)onEnter
{	
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    //[[CCDirector sharedDirector] touchDispatcher];
    
	// get shared game state instance
	sharedGameState = [Singleton sharedGameStateInstance];
	
	int r1 = 255;
	int r2 = 255;
	int g1 = arc4random() % 100;
	int g2 = arc4random() % 100;
	int b1 = arc4random() % 255;
	int b2 = arc4random() % 255;
	
	float t1 = 2 + arc4random() % 3;
	float t2 = 2 + arc4random() % 3;
	
	
	id a1 = [CCTintTo actionWithDuration:t2 red:r1 green:g1 blue:b1];
	id a2 = [CCTintTo actionWithDuration:t1 red:r2 green:g2 blue:b2];
	
	float origScale = self.scale;
	
	id a3 = [CCScaleBy actionWithDuration:t1 scale:0.6];
	id a4 = [CCScaleTo actionWithDuration:t2 scale:origScale];
	
	CCAction *loop2 = [CCRepeatForever actionWithAction:
					  [CCSequence actions:
					   a1,
					   a2,
					   nil]
					  ];
	
	CCAction *loop3 = [CCRepeatForever actionWithAction:
					   [CCSequence actions:
						a1,
						a3,
						a2,
						a4,
						nil]
					   ];
	
	if(sharedGameState.currentLevel == 2){
		[self runAction:loop2];
	}
	
	if(sharedGameState.currentLevel == 3){
		[self runAction:loop3];
	}
	
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    //[[CCDirector sharedDirector] removeFromParentViewController];
	[super onExit];
}

+ (id)actor {
	
	Circle *actor = nil;
    if ((actor = [[[super alloc] initWithFile:@"circle.png"] autorelease])) {
    }
	
	return actor;
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	return CGRectContainsPoint([self rect], [self convertTouchToNodeSpace:touch]);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if ( ![self containsTouchLocation:touch] ) return NO;
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	
	sharedGameState.clickedCircle = self.tag;
	[self.parent performSelector:@selector(doTouch)];
}


@end

