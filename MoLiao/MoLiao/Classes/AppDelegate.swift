//
//  AppDelegate.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/24.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit
import CoreData
import Hyphenate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,EMClientDelegate{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.backgroundColor = kBgColor
        
        
        // 登录界面
//        let vc = HomePageController()
//        let nvc = BaseNavgationController.init(rootViewController: vc)
        // OtherInformationController BaseTabBarController
        self.window?.rootViewController = UserNameController()
        
        
//        self.window?.rootViewController = BaseNavgationController(rootViewController: MLRegistGenderController()) // BaseNavgationController(rootViewController: UserNameController())
//        window?.makeKeyAndVisible()
        
        /*
        //AppKey:注册的AppKey，详细见下面注释。
        //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
        let options = EMOptions(appkey: "1119160930178083#moliao")
        //options?.apnsCertName = "istore_dev"
        EMClient.shared().initializeSDK(with: options)
        
        //添加EMClient的代理
        EMClient.shared()?.add(self, delegateQueue: nil)
        
        UserDefaults.standard.set("https://tjcentamepictest.centaline.com.cn/DocFiles/AdPicture/956241_20180723171717.png", forKey: "headUrlImage")
        UserDefaults.standard.set("徐庆标", forKey: "nickName")
        UserDefaults.standard.synchronize()

        
        //执行登录的请求
        EMClient.shared().login(withUsername: "xu", password: "123") { (aUsername, aError) in
            if (aError != nil) {
                print("登录失败 \(aError!.code)")
                
                if (aError?.code == EMErrorUserAuthenticationFailed) {
                    print("密码错误 \(aError!.code)")
                    
                } else if (aError?.code == EMErrorUserNotFound) {
                    print("用户不存在 \(aError!.code)")
                }
                
            }else {
                print("登录成功")
                
            }
        }

        */
        

        
        
        

        //        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

        // Override point for customization after application launch.
        return true
    }

    //EMClientDelegate中的方法，当前登录账号在其它设备登录时会接收到此回调
    func userAccountDidLoginFromOtherDevice() {
        
        self.window?.rootViewController = UserNameController()
        
        let alert = UIAlertController(title: "提醒", message: "当前帐号在其它设备登录，如非本人操作，请及时修改密码", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MoLiao")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

