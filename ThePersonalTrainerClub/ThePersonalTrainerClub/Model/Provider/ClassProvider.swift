//
//  NewClassProvider.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class ClassProvider {
    enum ClassError: Error {
        case unprocessableEntity
        case notFound
        case otherError
    }
    
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func create(model: ClassModel, completion: @escaping (Bool, Error?) -> Void) {
        webService.load(NewClassResponse.self, from: Endpoint.newClass(requestModel: ClassProviderMapper.mapModelToEntity(model: model))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.unprocessableEntity:
                    completion(false, ClassError.unprocessableEntity)
                default:
                    completion(false, ClassError.otherError)
                }
            } else {
                completion(true, nil)
            }
        }
    }
    
    func fetchClassesForTrainer(_ trainerId: String, completion: @escaping ([ClassModel]?, Error?) -> Void) {
        webService.load(TrainerClassResponse.self, from: Endpoint.trainerClasses(requestModel: TrainerClassRequest(trainerId: trainerId))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.notFound:
                    completion(nil, ClassError.notFound)
                default:
                    completion(nil, ClassError.otherError)
                }
            } else if let response = responseObject {
                completion(ClassProviderMapper.mapEntityToModel(response: response), nil)
            } else {
                completion(nil, ClassError.otherError)
            }
        }
    }
}

private class ClassProviderMapper {
    class func mapModelToEntity(model: ClassModel) -> NewClassRequest {
        return NewClassRequest(
            name: model.name,
            description: model.description,
            price: model.price,
            photo: model.photo,
            quota: model.quota
        )
    }
    
    class func mapEntityToModel(response: TrainerClassResponse) -> [ClassModel] {
        return response.data.map {
            return ClassModel(
                id: $0._id,
                name: $0.name,
                description: $0.description,
                price: $0.price,
                photo: $0.photo,
                quota: $0.quota
            )
        }
    }
}
