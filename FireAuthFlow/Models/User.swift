//
//  User.swift
//  FireAuthFlow
//
//  Created by Nguyễn Tuấn Dũng on 05/04/2024.
//

import Foundation

class User: Codable {
    var uid: String
    var name: String
    var avatar: String?
    var email: String
    var password: String // Lưu ý: Không nên lưu mật khẩu trực tiếp như thế này

    init(uid: String, name: String, avatar: String?, email: String, password: String) {
        self.uid = uid
        self.name = name
        self.avatar = avatar
        self.email = email
        self.password = password
    }
    
    // Hàm để cập nhật thông tin người dùng sau khi đã tạo tài khoản
    func updateInfor(name: String, avatar: String, password: String) {
        self.name = name
        self.avatar = avatar
        self.password = password
    }
    
    // Hàm để chuyển đổi từ model sang dictionary, sử dụng khi lưu dữ liệu lên Firebase
    func toDictionary() -> [String: Any] {
        return [
            "uid": uid,
            "name": name,
            "avatar": avatar ?? "",
            "email": email,
            "password": password // Lưu ý: Không nên lưu mật khẩu trực tiếp như thế này
        ]
    }
}

