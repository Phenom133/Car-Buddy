//
//  ContentView.swift
//  Car Buddy
//
//  Created by Jesus Ibarra on 4/24/22.
//

import SwiftUI
struct ButtonView: View{
    @State var pleaseWork = false
    var item: String
    var symbol: Float
    
    var body: some View{
        if symbol < 0.75{
            Button{
                pleaseWork = true
                //print("button \(key) \($isShowingPopover)")
           } label: {
               Image(systemName: "info.circle")
           }.popover(isPresented: $pleaseWork){
                Text(item)
                    .padding()
                    //.background(Color.black)
            }
            //.frame(width: 20, height: 20)
            .buttonStyle(PlainButtonStyle())
        } else if symbol < 0.90{
            Button{
                pleaseWork = true
                //print("button \(key) \($isShowingPopover)")
           } label: {
               Image(systemName: "exclamationmark.triangle.fill")
                   .foregroundColor(.yellow)
           }.popover(isPresented: $pleaseWork){
                Text(item)
                    .padding()
                    //.background(Color.black)
            }
            //.frame(width: 20, height: 20)
            .buttonStyle(PlainButtonStyle())
        } else {
            Button{
                pleaseWork = true
                //print("button \(key) \($isShowingPopover)")
           } label: {
               Image(systemName: "exclamationmark.octagon.fill")
                   .foregroundColor(.red)
           }.popover(isPresented: $pleaseWork){
                Text(item)
                    .padding()
                    //.background(Color.black)
            }
            //.frame(width: 20, height: 20)
            .buttonStyle(PlainButtonStyle())
        }
    }
}
struct ContentView: View {
    let testDict = ["Oil": "5000", "Transmission Oil": "10000", "Battery": "20000"]
    @State var rootWord = ""
    @State var name: [String] = []
    @State var amount: [Int] = []
    typealias Multivalue = (total: Int, current: Int, butt: Bool)
    @State var dictonary = [String: Multivalue]()
    @State var mLeft = Float(0.0)
    @State private var isShowingPopover = false
    @State var testingButt = [Bool]()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                Spacer()
            }.frame(height: geometry.size.height*0.0)
                .onAppear(perform: startGame)
            VStack{
            List{
                ForEach(dictonary.sorted(by: {$0.value.0 < $1.value.0}), id: \.key) { key, value in
                    
                //mLeft = Float(value.1)/Float(value.0)
                    
                        HStack{
                
                        Text(key)
                            .frame(width:geometry.size.width*0.2, height: geometry.size.height*0.06, alignment: .leading)
                            .font(.system(size: 15, weight: .bold))
                            .minimumScaleFactor(0.01)
                            .allowsTightening(true)
                            .lineLimit(3)
                            
                        VStack{
                            Text("Miles Remaining: \(value.0 - value.1)")
                                .font(.system(size: 12))
                                .frame(width:geometry.size.width*0.6)
                            
                            if Float(value.1) / Float(value.0) < 0.75{
                                ProgressView(value: Float(value.1) / Float(value.0))
                                    .frame(width:geometry.size.width*0.6)
                                    .tint(.green)
                            } else if Float(value.1) / Float(value.0) < 0.90{
                                ProgressView(value: Float(value.1) / Float(value.0))
                                    .frame(width:geometry.size.width*0.6)
                                    .tint(.yellow)
                            } else{
                                ProgressView(value: Float(value.1) / Float(value.0))
                                    .frame(width:geometry.size.width*0.6)
                                    .tint(.red)
                            }
                        }
                        HStack{
                            ButtonView(item: key, symbol: (Float(value.1) / Float(value.0)
                                                          ))
//                            Button{
//                                self.isShowingPopover = true
//                                print("button \(key) \($isShowingPopover)")
//                           } label: {
//                               Image(systemName: "info.circle")
//                           }.popover(isPresented: $isShowingPopover){
//                                Text("PopoverContent")
//                                    .padding()
//                                    .background(Color.black)
//                            }
//                            //.frame(width: 20, height: 20)
//                            .buttonStyle(PlainButtonStyle())
//                            Image("info")
//                                .resizable()
//                                .frame(width:20, height: 20, alignment: .center)
//                                .aspectRatio(contentMode: .fill)
//                                .onTapGesture(count: 1) {
//                                    self.isShowingPopover = true
//                                }
//                                .popover(isPresented: $isShowingPopover){
//                                    Text("PopoverContent")
//                                }
                                
                        }.padding(.leading, -20.0).frame(width: geometry.size.width*0.2, height: geometry.size.height*0.06)
                            Spacer()
                        }.frame(width: geometry.size.width, alignment: .center)
                        
                        
                
                
            }.frame(width: geometry.size.width, alignment: .center)
            }.listStyle(.plain).frame(width: geometry.size.width, alignment: .leading)
                //.frame(height:geometry.size.height*0.7)
//            VStack{
//                Text("\(rootWord)")
//            }.frame(width: geometry.size.width)
//                Button{
//                    self.isShowingPopover = true
//                    print("button \(isShowingPopover)")
//               } label: {
//                   Image(systemName: "info.circle")
//               }.popover(isPresented: $isShowingPopover) {
//                   Text("This sucks")
//                       .padding()
//               }
                //.frame(width: 20, height: 20)
                //.buttonStyle(PlainButtonStyle())
        }
        }
        
    }


func startGame(){
       if let startWordsURL = Bundle.main.url(forResource: "test1Data", withExtension: "txt") {
           if let startWords = try? String(contentsOf: startWordsURL) {
               //let allWords = startWords.components(separatedBy: "\n")
               rootWord = startWords
               splitter(block: rootWord)
               return
               
           }
       }

       fatalError("Could not load start.txt from bundle.")
   }
    func splitter(block: String){
        let lines = block.split(separator: ";")
        //typealias Multivalue = (total: Int, current: Int)
        var words: [String] = []
        for line in lines {
            //print(line)
            //print("_______")
            let test = line.split(separator: ",")
            let tests = test.map{String($0)}
//            for tet in test{
//                print(tet)
//                print("11111")
//            }
            words.append(contentsOf: tests)
        }
        var num = 0
        for word in words {
            //print(num)
            //print(word)
            //print(num)
            if num % 2 == 0 && num<36{
                name.append(word)
                //print("\(word) 1")
            } else if num < 36{
                let temp = Int(word)
                //print(temp!)
                amount.append(temp!)
            }
            num = num+1
        }
        //amount.sort(by: >)
        num = 0
        for nam in name {
            dictonary[nam] = Multivalue(total: amount[num],current: 5000,butt: false)
            num += 1
            testingButt.append(false)
            //print("\(nam) = \(amount[num-1])")
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11")
        }
    }
}
