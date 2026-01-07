//
//  Endpoints.swift
//  Therapy
//
//  Created by iOS Developer on 15/10/25.
//

enum Endpoints: String {
    case register = "auth/register"
    case login = "auth/login"
    case verifyOtp = "auth/verify-otp"
    case forgotPassword = "auth/forgot-password"
    case resetPassword = "auth/reset-password"
    case social = "auth/social"
    case refreshToken = "auth/refresh-token"
    case profile = "user/profile"
    case logout = "auth/logout"
}

enum HttpMehtods: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

enum HttpBodyType: String {
    case formData
    case urlEncoded
    case rawJSON
    case binary
    case graphQL
}
