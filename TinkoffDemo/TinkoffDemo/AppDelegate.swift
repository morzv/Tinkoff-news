//
//  AppDelegate.swift
//  TinkoffDemo
//
//  Created by Andrey Morozov on 21.09.2018.
//  Copyright © 2018 Jastic7. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	private var persistanceController: PersistanceController!


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		persistanceController = PersistanceController(modelName: "TinkoffDemo")
		
		guard let navigationController = window?.rootViewController as? UINavigationController,
			let newsFeedController = navigationController.viewControllers.first as? NewsFeedViewController else {
			fatalError("There is no NewsFeedVC")
		}
		
		
		let baseURL = "https://api.tinkoff.ru/"
		let transportLayer = TrasnportLayer(baseUrl: baseURL)
		
		let newsService = NewsService(transportLayer: transportLayer)
		newsService.output = newsFeedController
		newsFeedController.newsService = newsService
		
		let dataSource = NewsCoreDataDataSource<NewsFeedViewController>(persistanceController: persistanceController)
		dataSource.output = newsFeedController
		newsFeedController.dataSource = dataSource
		
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		persistanceController.save()
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		persistanceController.save()
	}


}

