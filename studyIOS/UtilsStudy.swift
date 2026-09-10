//
//  UtilsStudy.swift
//  studyIOS
//
//  Created by dhzy on 2026/9/7.
//

import Foundation


func onePrint(str:String) -> Bool {
    if (!str.isEmpty) {
        print(str)
        return true
    }else{
        print("内容不能为空")
        return false
    }
   
}

private func fetchData(url:String,compleSuccess:@escaping(Result<Data, Error>)->Void){
    guard let requestUrl = URL(string: url) else{
        compleSuccess(.failure(NSError(domain: "Invalid URL", code: -1)))
        return
    }
    var request = URLRequest(url: requestUrl)
    //httpMethod: "GET",
    request.httpMethod = "GET"
    SettingTask(requestUrl: request, compleSuccess: compleSuccess)
}


private func fetchDataPost(url:String,bodyDict: [Item]?,compleSuccess:@escaping(Result<Data, Error>)->Void){
    guard let requestUrl = URL(string: url) else{
        compleSuccess(.failure(NSError(domain: "Invalid URL", code: -1)))
        return
    }
    var request = URLRequest(url: requestUrl)
    //httpMethod: "GET",
    request.httpMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    // 将字典转换为 JSON Data
    if let strData = AppendString(dataValue: bodyDict) {
        request.httpBody = strData.data(using: .utf8)
        onePrint(str: strData)
    }
    SettingTask(requestUrl: request, compleSuccess: compleSuccess)
}


private func SettingTask(requestUrl:URLRequest,compleSuccess:@escaping(Result<Data, Error>)->Void){
    var request = requestUrl
    // 设置单个 Header (会覆盖同名的旧值)
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    if (HeaderValue.init().getHeaderSize()>0) {
        HeaderValue.init().getHeader().forEach{ item in
            request.setValue("\(item.value)", forHTTPHeaderField: item.key)
        }
    }
    let value = request.value(forHTTPHeaderField: "test")
    onePrint(str: value!)
    
    let task = URLSession.shared.dataTask(with: request){data,response,error in
        if let error = error{
            compleSuccess(.failure(error))
            return
        }
        
        let httpResponse = response as? HTTPURLResponse
        let code = httpResponse?.statusCode
        if(code!>200 || code!<200){
            compleSuccess(.failure(NSError(domain: "Server Error", code: -1)))
            return
        }
    
        if let data = data {
            compleSuccess(.success(data))
        }else{
            compleSuccess(.failure(NSError(domain: "No Data", code: -1)))
        }
        
    }
    task.resume()
}

func jsonElement<T: Decodable>(_entity:T.Type,data:Data,mainData:@escaping(T)->Void){
    let decoder = JSONDecoder()
    do {
        let model = try decoder.decode(_entity, from: data)
        DispatchQueue.main.async{
            mainData(model)
        }
    } catch {
        print("解析失败: \(error)")
    }
}
private func AppendString(dataValue:[Item]?)->String?{
    
    if let dataUrl = dataValue {
        let result = dataUrl.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        print("result \(result)")
        return  result
    }
    return nil
}
//get 请求 url请求地址  datavalue请求参数数组
func getRequest(url:String,dataValue:[Item]?,compleSuccess:@escaping(Result<Data, Error>)->Void) {
    var requestUrl = ""
    if let dataUrl = AppendString(dataValue: dataValue) {
        requestUrl = "\(url)?\(dataUrl)"
    }else{
        requestUrl = url
    }
    print("requestUrl \(requestUrl)")
    fetchData(url: requestUrl, compleSuccess: compleSuccess)
}

//get 请求 url请求地址  datavalue请求参数数组
func postRequest(url:String,bodyDict: [Item]?,compleSuccess:@escaping(Result<Data, Error>)->Void) {
    

    fetchDataPost(url: url, bodyDict: bodyDict, compleSuccess:compleSuccess)
}

struct Item {
    let key: String
    let value: Any
}

struct HeaderValue {
    private static var ALL_HEADER_ADD:[Item] = []
    func getHeaderSize() -> Int{
        return HeaderValue.ALL_HEADER_ADD.count
    }
    func addHeader(header:[Item])->HeaderValue{
        HeaderValue.ALL_HEADER_ADD.append(contentsOf:header)
        return HeaderValue.init()
    }
    func getHeader()->[Item]{
        return HeaderValue.ALL_HEADER_ADD
    }
}
