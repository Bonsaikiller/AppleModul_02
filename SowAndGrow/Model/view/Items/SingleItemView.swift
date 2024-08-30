//
//  SingleItemView.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 25.06.24.
//

import SwiftUI
import SwiftData

struct SingleItemView: View {
    
    let item: Item

    var body: some View {
    
        var textColor: Color {
            if(item.isDone == true) {
                return Color(red: 180/255, green: 180/255, blue: 180/255)
            } else {
                return Color.black
            }
        }
        
        // to check if task is overdue
         let datePicked = item.date
            var dateGone: Bool {
                  var a = false
                   if (datePicked < Date.now) {
                        a = true
                     //  print(Date.now)
                     //  print(datePicked)
                     //  print (a)
                        }
                        return a
                    }
        
        NavigationLink(value: item) {
                HStack(alignment: .center) {
                   
                    if (item.isDone == true) {
                        Image(systemName: "checkmark.circle")
                        .font(.system(size: 22))
                        .padding(.trailing, 7)
                    } else {
                        Image("\(item.task)")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding(.trailing)
                    }

                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.system(size: 16, weight: .bold))
                            //.font(.headline)
                           
                        if ((item.typeOfPlant != "") && (item.isDone == false)) {
                            Text(item.typeOfPlant)
                                .font(.system(size: 14, weight: .medium))
                                .italic()
                                .foregroundColor(.accentColor)
                        }
                       // If item is prioritized OR the date is overdue text will be displayed in red UNLESS the task was marked as done
                        if((item.priority == true) || (dateGone == true)) && (item.isDone == false) {
                            Text(item.task.rawValue + " bis " + ("\(item.date.formatted(date: .abbreviated, time: .omitted))"))
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.red)
                        } else {
                            Text(item.task.rawValue + " bis " + ("\(item.date.formatted(date: .abbreviated, time: .omitted))"))
                                .font(.system(size: 14, weight: .regular))
                        }
                    }
                    Spacer()
                    HStack(alignment: .bottom){
                        if(item.priority == true) && (item.isDone == false) {
                            Image(systemName: "light.beacon.max.fill")
                                .font(.system(size: 22))
                                .padding(.trailing, 7)
                                .foregroundColor(.red)
                        }
                    }
                 /*
                    else if (item.isFavorite == true) {
                            Image(systemName: "heart.fill")
                            //.resizable()
                            .font(.system(size: 20))
                            .padding(.trailing, 10)
                            .foregroundColor(.accentColor)
                    }  */
            }

                .foregroundColor(textColor)
        }
    }

}

/*
 #Preview {
 do {
 let config = ModelConfiguration(isStoredInMemoryOnly: true)
 let container = try ModelContainer(for: Item.self,
 configurations: config)
 let example = Item(name: "BlackCherry", typeOfPlant: "Tomate", task: .sow, priority: true, hasFavorite: Favorite(name:"BlackCherry"))
 return SingleItemView(item: example)
 .modelContainer(container)
 } catch {
 fatalError("didn't work")
 }
 
 }
 */
