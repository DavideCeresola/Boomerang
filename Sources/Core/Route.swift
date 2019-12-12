//
//  Router.swift
//  Boomerang
//
//  Created by Stefano Mondino on 05/02/2019.
//  Copyright © 2019 Synesthesia. All rights reserved.
//

import Foundation

public protocol Scene {}

public protocol Route {
    var createScene: () -> Scene? { get }
    func execute<T: Scene>(from scene: T?)
}

