//  
//  ImageSelectorPresenter.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class ImageSelectorPresenter: BasePresenter, ImageSelectorPresenterProtocol {
    
    // MARK: - Properties
        
    weak var ui: ImageSelectorPresenterDelegate?
    
    var images: [UIImage] = [.ic_black_woman, .ic_blond_woman, .ic_emo_worker, .ic_happy_man, .ic_ponytail_woman, .ic_white_woman, .ic_woman_orange, .ic_worker, .ic_victor, .ic_hipster, .ic_man_beard, .ic_modern_woman, .ic_man_beard_blond, .ic_woman_glasses, .ic_black_man]
    
    var selectedImage: UIImage = .ic_black_woman
    
    
    // MARK: - ImageSelectorPresenter Functions
    
    func selectImage(at index: Int) {
        selectedImage = images[index]
    }
}
