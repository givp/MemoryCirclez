//
//  HelloWorldLayer.m
//  Circlez
//
//  Created by GParvaneh on 08/01/2011.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "Circle.h"
#import "GameOver.h"

// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) endGame {
	sharedGameState.currentCircle = 0;
	sharedGameState.clickedCircle = 0;
	[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameOver node]]];
}

-(BOOL) isOverlapping: (CGRect) rect {
	
	
	// loop through array
	// see if each box in array intersects with new random rect 
	//
	
	for(Circle *aCircle in circleArray) {
		CGRect box = CGRectMake(aCircle.position.x, aCircle.position.y, aCircle.contentSize.width * aCircle.scale , aCircle.contentSize.height * aCircle.scale);
		
		if (CGRectIntersectsRect(box, rect)) {
			return YES;
		}
		//CCLOG(@"ddddddddddd %0.2f - %0.2f", box.origin.x, rect.origin.x);
	}	
		
	return NO;
	
}


-(void) addCircle {
	
	CGPoint cPosition;
	float newScale;
	ccColor3B cColor;
	
	if(sharedGameState.currentLevel == 1){
		cPosition = ccp(30 + arc4random() % 420, 30 + arc4random() % 260);
		newScale = 50 + arc4random() % 50;
		cColor = ccc3(255, arc4random() % 100, arc4random() % 255);
	}
	
	if(sharedGameState.currentLevel == 2){
		cPosition = ccp(30 + arc4random() % 420, 30 + arc4random() % 260);
		newScale = 50 + arc4random() % 50;
		cColor = ccc3(255, arc4random() % 100, arc4random() % 255);
	}
	
	if(sharedGameState.currentLevel == 3){
		cPosition = ccp(30 + arc4random() % 420, 30 + arc4random() % 260);
		newScale = 50 + arc4random() % 50;
		cColor = ccc3(200, 200, 200);
	}
	
	//CCLOG(@"%0.2f x %0.2f Color: %0.2f", cPosition.x, cPosition.y, newScale);
	
	//CCSprite *circle = [CCSprite spriteWithFile:@"circle.png"];
	Circle *circle = [Circle actor];
	circle.scale = newScale/100;
	circle.color = cColor;
	circle.position = cPosition;
	
	// now check see if this new position is ok, if not remove from self and create a new one
	if([self isOverlapping: CGRectMake(cPosition.x, cPosition.y, circle.contentSize.width * circle.scale + 10.0 , circle.contentSize.height * circle.scale + 10.0)]){
		[self addCircle];
	} else {
		[self addChild:circle];
		[circleArray addObject:circle];
		circle.tag = [circleArray count];
		sharedGameState.currentCircle = [circleArray count]; 
	}
	
}

-(void)menuMoved:(id)sender {
	
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	menuLayer.position = ccp(winSize.width,0);
	
}


-(void)menuAddCircle:(id)sender {
	[self addCircle];
}


-(void) doTouch {
	
	//CCLOG(@"Current is: %d - Clicked: %d", sharedGameState.currentCircle, sharedGameState.clickedCircle);
	
	if (sharedGameState.clickedCircle == sharedGameState.currentCircle) {
		
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		[label setString:[NSString stringWithFormat:@"%d", sharedGameState.currentCircle]];
		
		id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(menuMoved:)];
		id actionMoveAdd = [CCCallFuncN actionWithTarget:self selector:@selector(menuAddCircle:)];
		
		id a1 = [CCMoveTo actionWithDuration:0.5 position:ccp(0,0)];
		id move_ease_in = [CCEaseIn actionWithAction:[[a1 copy] autorelease] rate:0.5f];
		id a2 = [CCMoveTo actionWithDuration:0.5 position:ccp(-winSize.width*2,0)];
		id move_ease_out = [CCEaseOut actionWithAction:[[a2 copy] autorelease] rate:0.5f];
		[menuLayer runAction:[CCSequence actions:move_ease_in, actionMoveAdd,[CCDelayTime actionWithDuration:1.0f], move_ease_out, actionMoveDone, nil]];
		
		sharedGameState.totalCirclez = sharedGameState.currentCircle;
		
	} else {
		[self endGame];
	}

	
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		self.isTouchEnabled = YES;
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		// get shared game state instance
		sharedGameState = [Singleton sharedGameStateInstance];	
		
		//CCLOG(@"LEVELLLLLLLL: %d", sharedGameState.currentLevel);
		
		circleArray = [[NSMutableArray alloc] init];
		
		
		// add bg
		CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
		bg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:bg];
		
		
		[self addCircle];
		
		// add bg2
		CCSprite *bg2 = [CCSprite spriteWithFile:@"bg2.png"];
		bg2.position = ccp(winSize.width/2, winSize.height/2);
		
		menuLayer = [CCLayerColor layerWithColor:ccc4(70,70,70,255)];
		menuLayer.position = ccp(winSize.width,0);
		
		label = [CCLabelTTF labelWithString:@"" fontName:@"Arial Rounded MT Bold" fontSize:64];
		label.position =  ccp( menuLayer.contentSize.width /2 , menuLayer.contentSize.height/2 );
		
		[menuLayer addChild:bg2];
		[menuLayer addChild:label];
		
		[self addChild:menuLayer z: 100];
		
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[circleArray release];
	[super dealloc];
}
@end
