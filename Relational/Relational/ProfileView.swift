//
//  ProfileView.swift
//  Relational
//
//  Created by Funatsuki Kaito on 2019/12/18.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI

struct ProfileView: View {

    @State var isPresented = false
    var SliderModalPresentation: some View {
        NavigationView {
            Form {
                Section(header: Text("Header Background Color")) {
                    HStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 100)
                                .foregroundColor(Color.gray)
                        }
                    }
                }
            }

            .navigationBarTitle(Text("Settings"))
                .navigationBarItems(
                    trailing: Button (action: { self.isPresented = false } ) {
                        Text("Done")
                        .foregroundColor(.green)
                    }
            )
        }
    }

    var body: some View {
        VStack {
            VStack {
                Header()
                    .foregroundColor(Color.gray)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 250)
                ProfileImage()
                    .offset(y: -120)
                    .padding(.bottom, -130)
                VStack {
                    Text("My name")
                        .bold()
                        .font(.title)
                    Text("student")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding()
            }
            Spacer()
            Button (action: { self.isPresented = true }, label: {
                HStack {
                    Image(systemName: "slider.horizontal.3")
                        .imageScale(.large)
                    Text("Settings")
                        .bold()
                        .accessibility(label: Text("Settings"))
                }
                .padding()
            })
        }.sheet(isPresented: $isPresented, content: {
            self.SliderModalPresentation
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
