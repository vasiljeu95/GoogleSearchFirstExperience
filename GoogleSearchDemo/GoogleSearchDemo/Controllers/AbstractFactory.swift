//
//  AbstractFactory.swift
//  GoogleSearchDemo
//
//  Created by Stepan Vasiljeu on 2/4/19.
//  Copyright © 2019 Stepan Vasiljeu. All rights reserved.
//

import Foundation

protocol AbstractFactory {
    func createFunctionDownloadJson(progressView: UIProgressView, url: String) -> DownloadJson?
}
