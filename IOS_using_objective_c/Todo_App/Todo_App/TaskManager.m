//
//  TaskManager.m
//  Todo_App
//
//  Created by Thaowpsta Saiid on 27/04/2026.
//

#import "TaskManager.h"

@implementation TaskManager

//+ (instancetype)sharedManager {
//    static TaskManager *sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[self alloc] init];
//    });
//    return sharedInstance;
//}
//
//- (NSArray *)getAllTasks {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSArray *tasks = [defaults objectForKey:@"todoTasks"];
//    return tasks ? tasks : @[];
//}
//
//- (void)addTask:(NSDictionary *)task {
//    NSMutableArray *tasks = [[self getAllTasks] mutableCopy];
//    [tasks addObject:task];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:tasks forKey:@"todoTasks"];
//    [defaults synchronize];
//}
//
//- (void)updateTask:(NSDictionary *)task atIndex:(NSUInteger)index {
//    NSMutableArray *tasks = [[self getAllTasks] mutableCopy];
//    if (index < tasks.count) {
//        [tasks replaceObjectAtIndex:index withObject:task];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:tasks forKey:@"todoTasks"];
//        [defaults synchronize];
//    }
//}
//
//- (void)removeTaskAtIndex:(NSUInteger)index {
//    NSMutableArray *tasks = [[self getAllTasks] mutableCopy];
//    if (index < tasks.count) {
//        [tasks removeObjectAtIndex:index];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:tasks forKey:@"todoTasks"];
//        [defaults synchronize];
//    }
//}

+ (instancetype)sharedManager {
    static TaskManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)saveTasksArray:(NSArray<Task *> *)tasks {
    NSError *error;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tasks requiringSecureCoding:YES error:&error];
    
    if (data) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"todoTasks_v2"];
        [defaults synchronize];
    } else {
        NSLog(@"Error saving tasks: %@", error.localizedDescription);
    }
}

- (NSArray<Task *> *)getAllTasks {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"todoTasks_v2"];
    
    if (data) {
        NSError *error;
        NSSet *allowedClasses = [NSSet setWithObjects:[NSArray class], [Task class], nil];
        NSArray *tasks = [NSKeyedUnarchiver unarchivedObjectOfClasses:allowedClasses fromData:data error:&error];
        
        if (tasks) {
            return tasks;
        }
    }
    return @[]; 
}

- (void)addTask:(Task *)task {
    NSMutableArray *tasks = [[self getAllTasks] mutableCopy];
    [tasks addObject:task];
    [self saveTasksArray:tasks];
}

- (void)updateTask:(Task *)task atIndex:(NSUInteger)index {
    NSMutableArray *tasks = [[self getAllTasks] mutableCopy];
    if (index < tasks.count) {
        [tasks replaceObjectAtIndex:index withObject:task];
        [self saveTasksArray:tasks];
    }
}

- (void)removeTaskAtIndex:(NSUInteger)index {
    NSMutableArray *tasks = [[self getAllTasks] mutableCopy];
    if (index < tasks.count) {
        [tasks removeObjectAtIndex:index];
        [self saveTasksArray:tasks];
    }
}

@end
