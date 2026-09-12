//
//  SwiftUIView.swift
//  studyIOS
//
//  Created by dhzy on 2026/9/11.
//

import SwiftUI

struct SwiftUIView: View {
    @ObservedObject var modelData = HomeDataMode()
    
    var body: some View {
        List(modelData.dataList){ item in
            Text(item.title)
        }
    }
}


