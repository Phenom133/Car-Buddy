//
//  header.swift
//  Car Buddy
//
//  Created by Jesus Ibarra on 4/27/22.
//

import SwiftUI

struct header: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0){
                HStack{
                    Menu("Menu"){
                        Text("Car 1")
                        Text("Car 2")
                        Text("Car 3")
                    }.frame(width: geometry.size.width*0.2)
                    Text("Car Pal")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .frame(width: geometry.size.width*0.6)
                    Spacer().frame(width: geometry.size.width*0.2)
                }.background(Color.blue.opacity(0.6))
            }.background(Color.black)
                .frame(height: geometry.size.height*0.04, alignment: .topLeading)
            
        }.frame(height: UIScreen.main.bounds.height * 0.04, alignment: .top)
    }
}

struct header_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            header()
            ContentView()
        }
    }
}
