//
//  GameOver.h
//  Circlez
//
//  Created by GParvaneh on 10/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Singleton.h"
#import <GameKit/GameKit.h>

@interface GameOver : CCLayer {
	Singleton *sharedGameState;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end
