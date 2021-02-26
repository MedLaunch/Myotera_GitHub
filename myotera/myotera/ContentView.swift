//
//  ContentView.swift
//  myotera
//
//  Created by Mahmoud Komaiha on 2/24/21.
//

import SwiftUI
//import MovesenseApi


struct ContentView: View {
    @ObservedObject var updater = MovesenseDevices()
    @State var leftProgressValue: Float = 0.48
    @State var rightProgressValue: Float = 0.52
    @State private var searchText: String = ""
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                SearchBar(text: $searchText)
                switch updater.deviceUpdate {
                case .deviceDiscovered(_): Text("New Device")
                case .deviceStateChanged(_): Text("Device update")
                case .onError(let error): Text(error.localizedDescription)
                default: EmptyView()
                }
                List(updater.getInactiveDevicesFiltered(searchText)) { device in
                    ConnectTableItem(device: device)
                }
//                .onAppear() {
//                    UITableView.appearance().backgroundColor = UIColor.clear
//                    UITableViewCell.appearance().backgroundColor = UIColor.clear
//                }
                // Header
                VStack(alignment: .leading) {
                    Image("myoteraLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 68.0, height: 60.0)
                    Text("Hi Patrick!")
                        .foregroundColor(Color("mainTextColor"))
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Looks like you're making great progress")
                        .font(.subheadline)
                        .foregroundColor(Color("secondaryTextColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                // Body
                VStack(alignment: .leading) {
                    Spacer()
                    VStack {
                        // Recent Walk
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Recent Walk")
                                    .foregroundColor(Color("mainTextColor"))
                                    .font(.title)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            // Recent Walk Body
                            ZStack {
                                Color("bodyBackgroundColors")
                                VStack(alignment: .leading) {
                                    // Arm Graphs
                                    HStack {
                                        // Left Arm
                                        VStack(alignment: .center) {
                                            Text("Left Arm")
                                                .foregroundColor(Color("mainTextColor"))
                                                .font(.subheadline)
                                                .multilineTextAlignment(.leading)
                                            ProgressBar(progress: $leftProgressValue)
                                                .frame(width: 90.0, height: 90.0)
                                        }
                                        Spacer()
                                        // Right Arm
                                        VStack(alignment: .center) {
                                            Text("Right Arm")
                                                .foregroundColor(Color("mainTextColor"))
                                                .font(.subheadline)
                                                .multilineTextAlignment(.leading)
                                            ProgressBar(progress: $rightProgressValue)
                                                .frame(width: 90.0, height: 90.0)
                                        }
                                    }.padding(.horizontal, 20.0)
                                    Spacer()
                                    // Footer
                                    HStack {
                                        Text("40 min on Monday 2/15, 4:25 pm")
                                            .foregroundColor(Color("secondaryTextColor"))
                                            .font(.subheadline)
                                        Spacer()
                                        Text("See more")
                                            .foregroundColor(Color("appPurpleColor"))
                                            .font(.subheadline)
                                    }
                                }.padding(.all, 20.0)
                            }.overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("appPurpleColor"), lineWidth: 3)
                            )
                            .frame(height: 220.0)
                        }
                        Spacer()
                        // Recent Movement
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Recent Movement")
                                    .foregroundColor(Color("mainTextColor"))
                                    .font(.title)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            // Recent Walk Body
                            ZStack {
                                Color("bodyBackgroundColors")
                                VStack(alignment: .leading) {
                                    // Similarity
                                    Text("76% Similarity")
                                        .foregroundColor(Color("mainTextColor"))
                                        .font(.title)
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                    // Footer
                                    HStack {
                                        Text("Monday 2/15")
                                            .foregroundColor(Color("secondaryTextColor"))
                                            .font(.subheadline)
                                        Spacer()
                                        Text("See more")
                                            .foregroundColor(Color("appPurpleColor"))
                                            .font(.subheadline)
                                    }
                                }.padding(.all, 20.0)
                            }.overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("appPurpleColor"), lineWidth: 3)
                            )
                            .frame(height: 128.0)
                        }
                    }
                    Spacer()
                }.frame(maxHeight: 500)
                Spacer()
                Button(action: {
                    print(">> Delete tapped!\n")
                }) {
                    Text("+")
                        .font(.largeTitle)
                }
                .padding()
                .foregroundColor(Color("mainTextColor"))
                .background(Color("appPurpleColor"))
                .clipShape(Circle())
                .shadow(color: Color("appPurpleColor").opacity(0.4), radius: 15, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4.0)
            }
            .padding(.all, 20.0)
        }.onAppear(perform: {
            updater.startDevicesScan()
//            devices = updater.getInactiveDevicesFiltered(searchText)
//            print(updater.getActiveDevices().count)
        }).onDisappear(perform: {
            updater.stopDevicesScan()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
