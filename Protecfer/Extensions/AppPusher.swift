//
//  AppPusher.swift
//  Protecfer
//
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

import PusherSwift

struct AppPusher {
    
    static var pusher = Pusher(key: "777f49ce7e2a6cb91b3a", options: PusherClientOptions(host: .cluster("eu")))
    
    
}
