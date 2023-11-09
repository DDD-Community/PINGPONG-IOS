//
//  PingPongAPI+Authorization.swift
//  API
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum PingPongAPIAuthorization {
    public static let signupURL = String("signup")
    public static let validatUidURL = String("validate-uid")
    public static let validateNickNameURL = String("validate-nickname")
    public static let searchUserByUidURL = String("search-user-by-uid")
    public static let searchUserByidURL = String("search-user-by-id")
    public static let withdrawalURL = String("withdrawal")
    public static let userInfoURL = String("user-info/")
    public static let loginEmailURL = String("search-user-by-email/")
}
