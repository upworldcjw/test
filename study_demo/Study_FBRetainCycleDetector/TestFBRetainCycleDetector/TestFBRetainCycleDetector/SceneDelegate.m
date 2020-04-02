#import "SceneDelegate.h"
#import "XXObject.h"
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>
#import <objc/runtime.h>
#include <malloc/malloc.h>

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
//    XXObject *object = [[XXObject alloc] init];
//
//    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
//    [detector addCandidate:object];
//    __unused NSSet *cycles = [detector findRetainCycles];
//    NSLog(@"cjw cjw %@",cycles);
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    calloc(1, 40);
    struct Struct1 myStruct1;
    struct Struct2 myStruct2;
    NSLog(@"%lu - %lu",sizeof(myStruct1),sizeof(myStruct2));
    XXObject *object = [[XXObject alloc] init];

    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
    [detector addCandidate:object];
    __unused NSSet *cycles = [detector findRetainCycles];
//    __unused NSSet *cycles = [detector findRetainCycles];
    
    FBObjectiveCObject *layoutObj = [[FBObjectiveCObject alloc] initWithObject:object configuration:[FBObjectGraphConfiguration new]];
    __unused NSSet *allRetainedObjects = [layoutObj allRetainedObjects];

    NSLog(@"cjw cjw %@",allRetainedObjects);
    //对象字节对齐是以16字节对齐.而属性为8字节对齐
    NSLog(@"%lu--------%lu",class_getInstanceSize([object class]), malloc_size((__bridge const void *)(object)));
//    打印结果为40 ---- ---- 48
//    NSLog(@"sizeof %d instancesize %d",sizeof(layoutObj),);
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
