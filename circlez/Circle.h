//
//  Circle.h
//  Circlez
//
//  Created by GParvaneh on 09/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Singleton.h"

@interface Circle : CCSprite <CCTargetedTouchDelegate> {
	Singleton *sharedGameState;
}

+ (id)actor;

@end
