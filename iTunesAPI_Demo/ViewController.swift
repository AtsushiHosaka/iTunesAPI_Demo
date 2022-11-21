//
//  ViewController.swift
//  iTunesAPI_Demo
//
//  Created by 保坂篤志 on 2022/11/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var musicData = [MusicData]() {
        
        didSet {
            
            for data in musicData {
                
                print(data.trackName, data.artistName)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchMusic(term: "ado")
    }
    
    func searchMusic(term: String) {
        
        let parameters = ["term": term, "country": "jp", "limit": "5"]
        
        //黄色エラーが出てますが、こんな感じで書いていました
        AF.request("https://itunes.apple.com/search", parameters: parameters)
            .responseJSON { response in
            
            switch response.result {
                
            case .success:
                
                guard let data = response.data else { return }
                
                do {
                    
                    let response: Response = try JSONDecoder().decode(Response.self, from: data)
                    self.musicData = response.results
                    
                } catch {
                    
                    print(error)
                }
                
            case .failure:
                
                print("failure")
            }
            
                
        
            //上の黄色エラーを回避するためだとこういう書き方があります。
            AF.request("https://itunes.apple.com/search", parameters: parameters)
                    .validate(statusCode: 200..<300)
                    .validate(contentType: ["application/json"])
                    .responseData { response in
                
                //同じなので略
            }
        }
    }
}
    
