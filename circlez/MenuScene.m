//
//  MenuScene.m
//  Circlez
//
//  Created by GParvaneh on 11/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuScene.h"
#import "GameConfig.h"
#import "HelloWorldScene.h"
#import "CreditsScene.h"


@implementation MenuScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuScene *layer = [MenuScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)setLevel: (id) sender {
	
	CCMenuItem *item = (CCMenuItem *)sender;
	
	sharedGameState.currentLevel = item.tag;
	[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[HelloWorld node]]];
}

-(void)credits: (id) sender {
	
	[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[CreditsScene node]]];
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		//self.isTouchEnabled = YES;
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		// load sprites into cache
		//[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sprites.plist"];
		
		// get shared game state instance
		sharedGameState = [Singleton sharedGameStateInstance];	
		
		// game center
		if(kGameCenterOn){
			GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
			
			[localPlayer authenticateWithCompletionHandler:^(NSError *error) {
				if(!error){
					sharedGameState.isAuthenticated = YES;
					sharedGameState.userId = localPlayer.playerID;
				} else {
					sharedGameState.isAuthenticated = NO;
				}
				
			}];
		}
		
		
		
		
		// add bg
		CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
		bg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:bg];
		
		CCSprite *logo = [CCSprite spriteWithFile:@"logo.png"];
		logo.position = ccp(winSize.width/2, 250);
		[self addChild:logo];
		
		
		[CCMenuItemFont setFontName: @"Arial Rounded MT Bold"];
		[CCMenuItemFont setFontSize:28];
		
		CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"Easy" target:self selector:@selector(setLevel:)];
		CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"Medium" target:self selector:@selector(setLevel:)];
		CCMenuItemFont *item3 = [CCMenuItemFont itemWithString:@"Hard" target:self selector:@selector(setLevel:)];
		CCMenuItemFont *item4 = [CCMenuItemFont itemWithString:@"Help & Credits" target:self selector:@selector(credits:)];
		
		item1.tag = 1;
		item2.tag = 2;
		item3.tag = 3;
		
		item1.color = ccc3(255, 200, 0);
		item2.color = ccc3(255, 100, 0);
		item3.color = ccc3(255, 30, 0);
		item4.color = ccc3(170, 170, 170);
        item4.fontSize = 20;
		
		CCMenu *mainMenu = [CCMenu menuWithItems:item1, item2, item3, item4, nil];
		mainMenu.position = ccp(winSize.width/2, 130);
		[mainMenu alignItemsVerticallyWithPadding:7];
		[self addChild:mainMenu];
		
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}
@end

