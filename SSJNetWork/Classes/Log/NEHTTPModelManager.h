//
//  NEHTTPModelManager.h
//  SJNetWork
//
//  Created by Sunjie on 2019/4/16.
//  Copyright © 2019 sxmaps. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SSJHTTPSessionModel;

NS_ASSUME_NONNULL_BEGIN

@interface NEHTTPModelManager : NSObject

{
    NSMutableArray *allRequests;
    BOOL enablePersistent;
}

@property(nonatomic,strong) NSString *sqlitePassword;
@property(nonatomic,assign) NSInteger saveRequestMaxCount;

/**
 *  get recorded requests 's SQLite filename
 *
 *  @return filename
 */
+ (NSString *)filename;

/**
 *  get NEHTTPModelManager's singleton object
 *
 *  @return singleton object
 */
+ (instancetype)defaultManager;

/**
 *  create NEHTTPModel table
 */
- (void)createTable;


/**
 *  add a NEHTTPModel object to SQLite
 *
 *  @param aModel a NEHTTPModel object
 */
- (void)addModel:(SSJHTTPSessionModel *) aModel;

/**
 *  get SQLite all NEHTTPModel object
 *
 *  @return all NEHTTPModel object
 */
- (NSMutableArray *)allobjects;

/**
 *  delete all SQLite records
 */
- (void) deleteAllItem;

- (NSMutableArray *)allMapObjects;
- (void)addMapObject:(SSJHTTPSessionModel *)mapReq;
- (void)removeMapObject:(SSJHTTPSessionModel *)mapReq;
- (void)removeAllMapObjects;



@end

NS_ASSUME_NONNULL_END
