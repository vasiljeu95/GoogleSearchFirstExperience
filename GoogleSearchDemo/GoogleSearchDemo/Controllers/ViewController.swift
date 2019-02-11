//
//  ViewController.swift
//  GoogleSearchDemo
//
//  Created by Stepan Vasiljeu on 1/30/19.
//  Copyright © 2019 Stepan Vasiljeu. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate  {
    
    //MARK: - QUEUE
    let requestQueue = DispatchQueue.global(qos: .userInitiated)
    let jsonParsingQueue = DispatchQueue.global(qos: .userInitiated)
    
    //MARK: - CELL
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linksInItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "googleSearchAddressCell", for: indexPath)
        cell.textLabel!.text = linksInItem[indexPath.row]
        return cell
    }
    
    //MARK: - OURLET
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var searchButton: UIButton!
    
    private var linksInItem : Array<String> = []
    private var downloadURL: URLSessionTask = URLSessionTask()
    
    private var processingRequest = false
    
    //MARK: - FUNCTION
    private func urlSearchRequest(searchText: String) -> URL? {
        let firstQuery = "AIzaSyC5yPrC3W3pc9yWX2zIBv7VOyZC_C0xB70"
        let secondQuery = "009554791418314018500:efecjccvhra"

        if let url = URL(string: "https://www.googleapis.com/customsearch/v1?q=" + searchText + "&key=" + firstQuery + "&cx=" + secondQuery) {
            return url
        } else {
            return nil
        }
    }
    
    private func urlSearchRequestString(searchText: String) -> String {
        let firstQuery = "AIzaSyC5yPrC3W3pc9yWX2zIBv7VOyZC_C0xB70"
        let secondQuery = "009554791418314018500:efecjccvhra"
        
        if let url: String = String("https://www.googleapis.com/customsearch/v1?q=" + searchText + "&key=" + firstQuery + "&cx=" + secondQuery) {
            return url
        }
    }
    
    private func downloadJson() {
        searchTextField.endEditing(true)
        processingRequest = true
        if let url = urlSearchRequest(searchText: searchTextField.text!) {
            self.downloadURL = URLSession.shared.dataTask(with: url) {
                (data, urlResponse, error) in
                guard let data = data else {return}
                do {
                    try self.jsonParsingQueue.sync {
                        let decoder = try JSONDecoder().decode(GoogleSearchJSON.self, from: data)
                        if decoder.items != nil {
                            self.linksInItem.removeAll()
                            decoder.items!.forEach{
                                print($0.link!)
                                self.linksInItem.append($0.link!)
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                } catch {
                    print(error)
                }
                self.beforeSearch()
                self.processingRequest = false
            }
            requestQueue.async {
                self.duringSearch()
                self.downloadURL.resume()
            }
        } else {
            print("Invalid url")
        }
    }
    
    private func fetchResponse(url: String) {
        request(url)
            .downloadProgress(closure: { (progress) in
                print("totalUnitCount: \(progress.totalUnitCount)")
                print("completedUnitCount: \(progress.completedUnitCount)")
                print("fractionCompleted: \(progress.fractionCompleted)")
                print("localizedDescription: \(progress.localizedDescription!)")
                print("_______________________________________________________")
                
                self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
            })
            .response { (response) in
                DispatchQueue.main.async {
                    self.progressView.isHidden = true
                }
        }
    }
    
    private func stopSearch(){
        self.requestQueue.async {
            self.downloadURL.cancel()
        }
        print("Search stopped")
        self.processingRequest = false
        beforeSearch()
    }
    
    private func buttonTheSearch(){
        if !processingRequest {
            downloadJson()
        } else {
            stopSearch()
        }
    }
    
    private func duringSearch(){
        DispatchQueue.main.async {
            self.searchButton.setTitle("Stop", for: .normal)
            self.progressView.isHidden = false
        }
    }
    
    private func beforeSearch(){
        DispatchQueue.main.async {
            self.searchButton.setTitle("Google Search", for: .normal)
            self.progressView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.setTitle("Google Search", for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissText))
        view.addGestureRecognizer(tapGesture)
        
        searchTextField.returnKeyType = UIReturnKeyType.search
        searchTextField.delegate = self
        
        let urlSearch = urlSearchRequestString(searchText: searchTextField.text!)
        fetchResponse(url: urlSearch)
    }
    
    @IBAction func pressSearchButton(_ sender: UIButton) {
        buttonTheSearch()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.searchTextField {
            buttonTheSearch()
        }
        return true
    }
    
    @objc func dismissText(){
        searchTextField.endEditing(true)
    }
    
}

