//
//  data.swift
//  studyIOS
//
//  Created by dhzy on 2026/9/7.
//
import Foundation
import Combine


class HomeDataMode: ObservableObject{
    @Published var title: String = "模拟数据"
    @Published var score: Int = 0
        
        func  refreshData() {
            // 模拟网络请求或数据处理
//            fetchData(
//                url:"",
//                compleSuccess:{result in
//                    switch result {
//                        case .success(let data):
//                            print("收到数据: \(data.count) bytes")
//                            jsonElement(_entity: MyModel.self, data: data,mainData:{ model in
//                                self.title = model.data[0].title
//                                self.score = 100
//                            })
//                            //优化解析
////                            let decoder = JSONDecoder()
////                            do {
////                                let model = try decoder.decode(MyModel.self, from: data)
////                                print(model.data[0].id)
////                                DispatchQueue.main.async{
////                                    self.title = model.data[0].title
////                                    self.score = 100
////                                }
////
////
////                            } catch {
////                                print("解析失败: \(error)")
////                            }
//                        case .failure(let error):
//                            print("请求失败: \(error.localizedDescription)")
//                        }
//                })
            //Get请求
//            let items = [
//                Item(key: "id", value: "101"),
//                Item(key: "status", value: "active")
//            ]
//            getRequest(url:"url",dataValue: nil,compleSuccess: {result in
//                switch result {
//                case .success(let data):
//                    print("收到数据: \(data.count) bytes")
//                    jsonElement(_entity: MyModel.self, data: data,mainData:{ model in
//                        self.title = model.data[0].title
//                        self.score = 100
//                    })
//                case .failure(let error):
//                    print("请求失败: \(error.localizedDescription)")
//                }
//            })
            //username,password,repassword
            //"username": "john_doe",
            //"password": "repassword",
            //"repassword":"123456"
            let bodyDict: [Item] = [
                Item(key: "username",value: "john4"),
                Item(key: "password",value: "123456"),
                Item(key: "repassword",value: "123456")
            ]
            postRequest(url: "url", bodyDict: bodyDict, compleSuccess: {result in
                switch result {
                case .success(let data):
                    print("收到数据: \(data.count) bytes")
                    jsonElement(_entity: MyRModel.self, data: data,mainData:{ model in
                        if(model.errorCode == 0){
                            self.title = model.data!.nickname
                            self.score = model.data!.id
                        }else{
                            self.title = "注册失败"
                            self.score = -1
                        }
                        
                    })
                case .failure(let error):
                    print("请求失败: \(error.localizedDescription)")
                }
            })
        }
}

struct MyRModel: Codable {
    let errorCode: Int
    let errorMsg: String?
    let data:DataRModel?
}

struct DataRModel:Codable {
    let nickname:String
    let id:Int
}

struct MyModel: Codable {
    let errorCode: Int
    let errorMsg: String
    let data:[DataModel]
}

struct DataModel:Codable {
    let title:String
    let id:Int
}


//{
//  "data": {
//    "admin": false,
//    "chapterTops": [],
//    "coinCount": 0,
//    "collectIds": [],
//    "email": "",
//    "icon": "",
//    "id": 173382,
//    "nickname": "john1",
//    "password": "",
//    "publicName": "john1",
//    "token": "",
//    "type": 0,
//    "username": "john1"
//  },
//  "errorCode": 0,
//  "errorMsg": ""
//}
