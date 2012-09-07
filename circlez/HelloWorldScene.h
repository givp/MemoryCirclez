//
//  HelloWorldLayer.h
//  Circlez
//
//  Created by GParvaneh on 08/01/2011.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Singleton.h"

// HelloWorld Layer
@interface HelloWorld : CCLayer
{
	Singleton *sharedGameState;
	NSMutableArray *circleArray;
	CCLayerColor *menuLayer;
	CCLabelTTF *label;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

-(void) doTouch;

@end
