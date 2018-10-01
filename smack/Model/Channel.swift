//
//  Channel.swift
//  smack
//
//  Created by Paul Jablonski on 01/10/2018.
//  Copyright © 2018 Oxido. All rights reserved.
//

import Foundation

struct Channel: Decodable {
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var _id: String!
    public private(set) var __v: Int?
}
