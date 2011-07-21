//
//  Movie.h
//  sample
//
//  Created by xvonabur on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"

@interface Movie : NSObject {
   
    
    NSInteger movieID;
    NSString *movieName;
    NSInteger channelID;
    
    // The boolean “isDirty” tells us if the object was changed in memory or not.
    //“isDetailViewHydrated” tell us, if the data which shows up on the detail view is fetched from the database or not.
    BOOL isDirty;
    BOOL isDetailViewHydrated;
}
@property (nonatomic, readonly) NSInteger movieID;
@property (nonatomic, copy) NSString *movieName;
@property (nonatomic, readonly) NSInteger channelID;


@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

//Static methods.
//“getInitialDataToDisplay” gets the data from the database and creates “Movie” objects using “initWithPrimaryKey” method and fills the objects in the MoviesArray which is declared in sampleAppDelegate.
+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;

//

@end
