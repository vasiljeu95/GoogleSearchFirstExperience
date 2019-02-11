//
//  ProtocolDownloadDelegate.swift
//  
//
//  Created by Stepan Vasiljeu on 2/3/19.
//

import Foundation

protocol DownloadDelegate: class {
    func downloadProgressUpdate(for progress: Float)
}
