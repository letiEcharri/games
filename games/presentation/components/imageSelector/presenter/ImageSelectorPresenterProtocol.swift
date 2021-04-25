//  
//  ImageSelectorPresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

protocol ImageSelectorPresenterProtocol where Self: BasePresenter {
    
    var ui: ImageSelectorPresenterDelegate? { get set }
    var images: [UIImage] { get }
    var selectedImage: UIImage { get set }
    
    func selectImage(at index: Int)
}

protocol ImageSelectorPresenterDelegate: BasePresenterDelegate {
    
}
