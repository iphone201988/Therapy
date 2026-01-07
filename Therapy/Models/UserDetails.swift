//
//  UserDetails.swift
//  Therapy
//
//  Created by iOS Developer on 15/10/25.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let success: Bool?
    let message, token, resetToken: String?
    let data: UserData?
}

struct UserData: Codable {
    let user: UserDetails?
    let tokens: UserDetails?
    let resetToken: String?
}

// MARK: - UserData
struct UserDetails: Codable {
    let id, name, email, profilePicture, phoneNumber, accessToken, refreshToken: String?
    let isPremium, onboardingCompleted, biometricEnabled, notificationsEnabled: Bool?
    let role, subscriptionStatus, subscriptionExpiresAt, lastLoginAt, deviceToken, deviceType: String?
    let isActive, isDeactivated, isEmailVerified: Bool?
    let otpCode, otpCodeExpiry, resetToken: String?
}
