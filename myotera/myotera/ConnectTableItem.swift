//
//  ConnectTableItem.swift
//  myotera
//
//  Created by Mahmoud Komaiha on 2/25/21.
//

import SwiftUI

struct ConnectTableItem: View {
    var device: DeviceViewModel
    var body: some View {
        VStack {
//            Text(device.serialLabel)
            Text(device.name)
            Text(device.rssi)
        }.foregroundColor(Color("secondaryTextColor"))
        
    }
}

//struct ConnectTableItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnectTableItem()
//    }
//}
