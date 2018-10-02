//
//  SocketService.swift
//  smack
//
//  Created by Paul Jablonski on 02/10/2018.
//  Copyright © 2018 Oxido. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    override init(){
        super.init()
    }
    
    let manager = SocketManager(socketURL: URL(string: "\(BASE_URL)")!)
    lazy var socket: SocketIOClient = manager.defaultSocket

    func  establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }

    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            let newChannel = Channel.init(name: channelName, description: channelDescription, _id: channelId, __v: 2)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    
    
    
}
