//
//  CreditsScene.h
//  Circlez
//
//  Created by GParvaneh on 11/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Singleton.h"

@interface CreditsScene : CCLayer {
	Singleton *sharedGameState;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end
