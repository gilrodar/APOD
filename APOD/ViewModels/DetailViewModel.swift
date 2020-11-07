//
//  DetailViewModel.swift
//  APOD
//
//  Created by Gil Rodarte on 06/11/20.
//

import Foundation

class DetailViewModel {
    
    // MARK: Properties
    
    var photoInfo: ((PhotoInfo) -> ())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    var showError: ((Error) -> ())?
    
    var date: Date
    
    var dateString: String {
        date.toString()
    }
    
    // MARK: Lifecycle
    
    init(date: Date) {
        self.date = date
    }
    
    // MARK: Methods
    
    func getInfo() {
        showLoading?()
        
        let date = self.date.toString(dateFormat: "yyyy-MM-dd")
        
        NetworkManager.shared.getPhotoInfo(date: date) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case.success(let photoInfo):
                self.photoInfo?(photoInfo)
            case .failure(let error):
                self.showError?(error)
            }
            
            self.hideLoading?()
        }
    }
    
}
