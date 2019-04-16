//
//  Constant.swift
//  Hosee
//
//  Created by Duc Anh on 4/12/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let toggle                 = Notification.Name("toggle")
}

enum Keys : String {
    case access_token = "access_token"
}

enum SegueIdentifier : String {
    case goToMain = "goToMain"
    case showBooking = "showBooking"
}

enum WorkingType {
    case camera
    case airCool
    case light
    
    var title: String {
        switch self {
        case .camera:
            return "Sửa chữa Camera"
        case .airCool:
            return "Sửa chữa Điều Hoà"
        case .light:
            return "Sửa chữa Đèn"
        }
    }
}

struct ConstantString {
    static let normalNavigationButtonTitle = "Chọn danh mục sửa chữa"
    static let  pickupPlacePlease = "Bấm vào đây để chọn địa điểm!"
}
