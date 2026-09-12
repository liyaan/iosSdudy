//
//  ContentView.swift
//  studyIOS
//
//  Created by dhzy on 2026/9/7.
//

import SwiftUI
struct ContentView: View {
    @State private var message = "初始数据"
    @ObservedObject var model = HomeDataMode()
    init() {
        model.refreshData()
    }
    var body: some View {
        
        VStack(){
            Text(model.title)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color.red)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .lineLimit(3)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .onTapGesture(count: 1, perform: {
                    printone(str:"aaaa")
                    printone(str:"")
                })
            
            Button(action:{
                HeaderValue.init().addHeader(header: [Item(key: "test", value: "test_101")])
                
                model.refreshData()
            }){
                Text("ios click").font(.largeTitle)
            }
            SwiftUIView(modelData: model)
        }
        
        
    }
    func printone(str:String)  {
        let result = onePrint(str: str)
        print(result)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
