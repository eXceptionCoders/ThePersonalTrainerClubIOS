//
//  TrainerManagementUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation
import UIKit

class TrainerManagementUseCase {
    
    private var userProvider: UserProvider
    private var classProvider: ClassProvider
    private var bookingProvider: BookingProvider
    
    init(userProvider: UserProvider, classProvider: ClassProvider, bookingProvider: BookingProvider) {
        self.userProvider = userProvider
        self.classProvider = classProvider
        self.bookingProvider = bookingProvider
    }
    
    func fetchUser(completion: @escaping (UserModel?, Error?, [String: String]?) -> Void) {
        userProvider.fetchUser(completion: completion)
    }
    
    func setUserThumbnail(_ image: UIImage, completion: @escaping (Bool, Error?, [String: String]?) -> Void) {
        userProvider.setUserThumbnail(image: image, completion: completion)
    }
    
    func deleteClass(classId: String, completion: @escaping (Bool, Error?, [String: String]?) -> Void) {
        classProvider.deleteClass(classId: classId, completion: completion)
    }
    
    func book(classId: String, completion: @escaping (Bool, Error?, [String: String]?) -> Void) {
        bookingProvider.book(classId: classId, completion: completion)
    }
    
    func deleteBooking(bookId: String, completion: @escaping (Bool, Error?, [String: String]?) -> Void) {
        bookingProvider.deleteBooking(bookId: bookId, completion: completion)
    }
}
