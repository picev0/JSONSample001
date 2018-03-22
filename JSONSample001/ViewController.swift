//
//  ViewController.swift
//  JSONSample001
//
//  Created by Shuhei Murata on 2018/03/16.
//  Copyright © 2018年 xyz.pice001. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var label002: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
         //https://www.sejuku.net/blog/34776#SwiftyJSON
         //パースするJSON文字列
        let jsonString: String = "{\"id\":1, \"name\":\"Suzuki\"}"
        
        //JSON文字列をData型に変換
        var personalData: Data = jsonString.data(using: String.Encoding.utf8)!
        
        do {
            
            // パースする
            let items = try JSONSerialization.jsonObject(with: personalData) as! Dictionary<String, Any>
            print(items["id"] as! Int)// メンバid Intにキャスト
            print(items["name"] as! String)// メンバ name Stringにキャスト
        } catch {
            print(error)
        }
 */
        /*
        // https://picolica.com/2017/06/24/swift3-api-swiftyjson/
        
        let stringUrl = "https://www.gaitameonline.com/rateaj/getrate";
        
        let url = URL(string: stringUrl)
        let request = URLRequest(url: url!)
        
        //コンフィグを指定してHTTPセッションを生成
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main )
        
        //HTTP通信を実行
        // dataにJSONデータが入る
        let task:URLSessionDataTask = session.dataTask(with: request, completionHandler:
        {data, response, error in
            // エラーがあったら出力
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                //
                let json = try! JSON(data: data!)
                print(type(of: json))//シミュレータ画面には出ない
            }
        })
        
        task.resume()
        */
 
        /*
        //https://dev.classmethod.jp/smartphone/json-decoding-without-swiftyjson/
        
        
        struct Currencies: Codable {
            let high: Double
            let open: Double
            let bid: Double
            let currencyPairCode: String
            let ask: Double
            let low: Double
        }
        
        let stringUrl = "https://www.gaitameonline.com/rateaj/getrate";
        
        let url = URL(string: stringUrl)
        let request = URLRequest(url: url!)
        
        //コンフィグを指定してHTTPセッションを生成
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main )
        
        //HTTP通信を実行
        // dataにJSONデータが入る
        let task:URLSessionDataTask = session.dataTask(with: request, completionHandler:
        {data, response, error in
            // エラーがあったら出力
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                //
                //let jsonString = try! JSON(data: data!)
                
                    
                let currencies = try? JSONDecoder().decode(Currencies.self, from: data!)
                print(currencies?.currencyPairCode)
                
            }
         
         
 
        
        })
        
        task.resume()
 */
        struct Currencies: Codable {
            let high: String
            let open: String
            let bid: String
            let currencyPairCode: String
            let ask: String
            let low: String
        }
        
        struct CurArray: Codable {
            let quotes: [Currencies]
        }
        
        let url = URL(string: "https://www.gaitameonline.com/rateaj/getrate")!
        let decoder: JSONDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: url, options: [])
            let currencies = try decoder.decode(CurArray.self, from: data)
            currencies.quotes.forEach{quotes in self.label002.text = "\(quotes.currencyPairCode)"}
            self.label002.backgroundColor = UIColor.orange
            
        } catch {
            print(error)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

