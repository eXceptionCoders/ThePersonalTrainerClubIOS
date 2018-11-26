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
    
    func create(model: NewClassModel, completion: @escaping (Bool, Error?) -> Void) {
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
    class func mapModelToEntity(model: NewClassModel) -> NewClassRequest {
        return NewClassRequest(
            instructor: model.instructor,
            sport: model.sport,
            location: LocationEntity(
                type: model.location.type,
                description: model.location.description,
                coordinates: model.location.coordinates
            ),
            description: model.description,
            price: model.price,
            duration: model.duration,
            quota: model.quota
        )
    }
    
    class func mapEntityToModel(response: TrainerClassResponse) -> [ClassModel] {
        return response.data.map {
            return ClassModel(
                id: $0._id,
                sport: ActivityModel(
                    id: $0.sport._id,
                    name: $0.sport.name,
                    icon: $0.sport.icon,
                    category: ""
                ),
                location: LocationModel(
                    type: $0.location.type,
                    coordinates: $0.location.coordinates,
                    description: $0.location.description
                ),
                description: $0.description,
                price: $0.price,
                quota: $0.quota,
                duration: $0.duration
            )
        }
    }
}
