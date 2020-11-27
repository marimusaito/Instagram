//
//  PostData.swift
//  Instagram
//
//  Created by 齋藤万璃夢 on 2020/11/20.
//  Copyright © 2020 mari.saito. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var message: [String] = []
    var usrname: [String] = []

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.name = postDic["name"] as? String

        self.caption = postDic["caption"] as? String

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        if let message = postDic["message"] as? [String] {
            self.message = message
        }
        
        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
        
        
        // メッセージが空なら何も表示しない
        //if self.message == nil {
        //        self.message = ""
        //}
        
        
        
        
    }
}
