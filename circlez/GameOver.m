//
//  GameOver.m
//  Circlez
//
//  Created by GParvaneh on 10/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameOver.h"
#import "GameConfig.h"
#import "MenuScene.h"
#import "HelloWorldScene.h"


@implementation GameOver

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOver *layer = [GameOver node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)retry: (id) sender {
	
	[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[HelloWorld node]]];
}

-(void)menu: (id) sender {
	
	[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MenuScene node]]];
}

- (void)submitScore {
	
	// if user is signed in to GC, submit score on exit
	if(sharedGameState.isAuthenticated){
		GKScore* myScore = [[[GKScore alloc] init] autorelease];
		myScore.value = sharedGameState.totalCirclez;
		//myScore.value = 1;
		
		[myScore reportScoreWithCompletionHandler:^(NSError *error) {
			if (error) {
				CCLOG(@"error recording score");
			} else {
				CCLOG(@"Success! %d circlez", sharedGameState.totalCirclez);
			}
			
		}]; 		
	}	
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		//self.isTouchEnabled = YES;
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		// get shared game state instance
		sharedGameState = [Singleton sharedGameStateInstance];	
		
		// now update GC
		if(kGameCenterOn){
			[self submitScore];
		}
		
		// add bg
		CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
		bg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:bg];
		
		
		CCLabelTTF *templabel = [CCLabelTTF labelWithString:@":(" fontName:@"Arial Rounded MT Bold" fontSize:64];
		templabel.color = ccc3(255, 0, 0);
		templabel.position =  ccp( winSize.width/2 , 220 );
		[self addChild:templabel];
		
		
		[CCMenuItemFont setFontName: @"Arial Rounded MT Bold"];
		[CCMenuItemFont setFontSize:28];
		
		CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"Try again" target:self selector:@selector(retry:)];
		
		CCMenu *mainMenu = [CCMenu menuWithItems:item1, nil];
		mainMenu.position = ccp(winSize.width/2, 130);
		[mainMenu alignItemsVerticallyWithPadding:10];
		[self addChild:mainMenu];
		
		[CCMenuItemFont setFontSize:18];
		
		CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"Back to menu" target:self selector:@selector(menu:)];
		item2.color = ccc3(170, 170, 170);
		
		CCMenu *mainMenu2 = [CCMenu menuWithItems:item2, nil];
		mainMenu2.position = ccp(winSize.width/2, 35);
		[mainMenu2 alignItemsVerticallyWithPadding:5];
		[self addChild:mainMenu2];
		
	}
	return self;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}
@end
