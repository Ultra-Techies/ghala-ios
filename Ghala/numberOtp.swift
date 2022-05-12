//
//  numberOtp.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//
//
import SwiftUI

struct numberOtp: View {
    var user: User
    
    var body: some View {
        
        Text(user.phoneNumber)
    }
}

struct numberOtp_Previews: PreviewProvider {
    static var previews: some View {
        numberOtp(user: User())
    }
}
