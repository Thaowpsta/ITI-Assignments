//
//  TaskManager.h
//  Todo_App
//
//  Created by Thaowpsta Saiid on 27/04/2026.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskManager : NSObject

//+ (instancetype)sharedManager;
//- (void)addTask:(NSDictionary *)task;
//- (NSArray *)getAllTasks;
//- (void)updateTask:(NSDictionary *)task atIndex:(NSUInteger)index;
//- (void)removeTaskAtIndex:(NSUInteger)index;

+ (instancetype)sharedManager;
- (void)addTask:(Task *)task;
- (NSArray<Task *> *)getAllTasks;
- (void)updateTask:(Task *)task atIndex:(NSUInteger)index;
- (void)removeTaskAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
