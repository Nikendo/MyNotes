//
//  CustomTabBar.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 26.12.2022.
//

import SwiftUI

struct CustomTabBar: View {
    var body: some View {
        HStack {
            calendarView
            Spacer()
            newView
            Spacer()
            profileView
        }
        .padding(.horizontal, 44)
        .padding(.vertical, 16)
        .foregroundColor(.white)
        .background(Color.clear)
    }

    @ViewBuilder private var calendarView: some View {
        Button(
            action: {
                print("calendar view action")
            }, label: {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .padding(12)
                    .background(Color.blue)
                    .cornerRadius(28)
            }
        )
    }

    @ViewBuilder private var newView: some View {
        Button(
            action: {
                print("new view action")
            }, label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(28)
            }
        )
    }

    @ViewBuilder private var profileView: some View {
        Button(
            action: {
                print("profile view action")
            }, label: {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .padding(12)
                    .background(Color.blue)
                    .cornerRadius(28)
            }
        )
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
