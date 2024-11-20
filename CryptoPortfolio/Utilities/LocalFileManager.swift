//
//  LocalFileManager.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 15.10.2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    //MARK: - Properties
    static let instance = LocalFileManager()
    
    //MARK: - Init
    private init() {}
    
    //MARK: - Methods
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        createFolder(folderName: folderName)
        guard let data = image.pngData(),
              let url = getImageURL(imageName: imageName, folderName: folderName)
        else { return }
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image \(imageName). \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getImageURL(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolder(folderName: String) {
        guard let folderURL = getFolderURL(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: folderURL.path) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating folder \(folderName). \(error)")
            }
        }
    }
    
    private func getFolderURL(folderName: String) -> URL? {
        guard let folderURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        return folderURL.appendingPathComponent(folderName)
    }
    
    private func getImageURL(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getFolderURL(folderName: folderName) else { return nil }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
