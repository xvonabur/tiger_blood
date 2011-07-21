//
//  Movie.m
//  sample
//
//  Created by xvonabur on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Movie.h"

static sqlite3 *database = nil;

@implementation Movie
@synthesize movieID, movieName, channelID, isDirty, isDetailViewHydrated;


+ (void) getInitialDataToDisplay:(NSString *)dbPath {
    sampleAppDelegate *appDelegate = (sampleAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        const char *sql = "select id, name from movies";
        sqlite3_stmt *selectstmt;
        if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
            
            while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                Movie *movieObj = [[Movie alloc] initWithPrimaryKey:primaryKey];
                movieObj.movieName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                
                movieObj.isDirty = NO;
                
                [appDelegate.moviesArray addObject:movieObj];
                [movieObj release];
                
            }
        }
    }
    else
        sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

- (id) initWithPrimaryKey:(NSInteger) pk {
    [super init];
    movieID = pk;
    
    isDetailViewHydrated = NO;
    
    return self;
}
+ (void) finalizeStatements {
    if(database) sqlite3_close(database);
}

- (void)dealloc {
    
    
    [movieName release]; 
    
    [super dealloc];
}


@end
