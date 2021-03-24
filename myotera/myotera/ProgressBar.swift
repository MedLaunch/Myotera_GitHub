//
//  ProgressBar.swift
//  myotera
//
//  Created by Mahmoud Komaiha on 2/25/21.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                Circle()
                    .stroke(lineWidth: g.size.width * 0.05)
                    .foregroundColor(Color("progressCircleBackground"))
                    .padding(.horizontal, g.size.width * 0.05 / 2)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth:  g.size.width * 0.05, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color("progressCircleForeground"))
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
                    .padding(.horizontal, g.size.width * 0.05 / 2)
                Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                    .font(.system(size: g.size.height > g.size.width ? g.size.width * 0.3: g.size.height * 0.3))
                    .foregroundColor(Color("mainTextColor"))
                    .bold()
                
//                badgeSymbols
//                    .scaleEffect(1.0 / 4.0, anchor: .top)
//                    .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
            }
        }.scaledToFit()
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bodyBackgroundColors")
            ProgressBar(progress: .constant(0.78))
        }
    }
}
