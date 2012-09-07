//
//  CreditsScene.m
//  Circlez
//
//  Created by GParvaneh on 11/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreditsScene.h"
#import "MenuScene.h"


@implementation CreditsScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CreditsScene *layer = [CreditsScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)back: (id) sender {
	
	[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MenuScene node]]];
}

-(void)givlink: (id) sender {
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.givp.org"]];
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
		
		// add bg
		CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
		bg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:bg];
		
		CCSprite *logo = [CCSprite spriteWithFile:@"logo.png"];
		logo.position = ccp(winSize.width/2, 250);
		[self addChild:logo];
        
        /////////////////////////////////
        
        CCLabelTTF *helplabel = [CCLabelTTF labelWithString:@"Watch the screen closely and only click on the new circles. Beat your own score or compare with others on Game Center." fontName:@"Arial Rounded MT Bold" fontSize:14];
		helplabel.color = ccc3(170, 170, 170);
        CGSize containerSize = { winSize.width - 50, 50 };
        helplabel.dimensions = containerSize;
		helplabel.position =  ccp( winSize.width/2 , 190 );
		[self addChild:helplabel];
        
        
        [CCMenuItemFont setFontName: @"Arial Rounded MT Bold"];
		[CCMenuItemFont setFontSize:14];
		
		CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"Game developed by Giv Parvaneh" target:self selector:@selector(givlink:)];
		item2.color = ccc3(100, 100, 100);
		
		CCMenu *mainMenu2 = [CCMenu menuWithItems:item2, nil];
		mainMenu2.position = ccp(winSize.width/2, 85);
		[mainMenu2 alignItemsVerticallyWithPadding:5];
		[self addChild:mainMenu2];
        
        /////////////////////////////////
        
		
		[CCMenuItemFont setFontName: @"Arial Rounded MT Bold"];
		[CCMenuItemFont setFontSize:18];
		
		CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"Back to menu" target:self selector:@selector(back:)];
		item1.color = ccc3(170, 170, 170);
		
		CCMenu *mainMenu = [CCMenu menuWithItems:item1, nil];
		mainMenu.position = ccp(winSize.width/2, 35);
		[mainMenu alignItemsVerticallyWithPadding:5];
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

