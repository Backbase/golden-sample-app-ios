//
//  AddContactView.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 24/07/2024.
//

import Foundation
import SwiftUI

struct AddContactView: View {
    @State var name: String = ""
    @State var accountNumber: String = ""
    @ObservedObject var vm: AddContactViewModel
    
    init(vm: AddContactViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(localizedString("goldenSampleApp.more.contacts.title"))
                .font(.headline)
                .frame(maxWidth: .infinity)
            
            if vm.state == .contactAdded {
                Text(localizedString("goldenSampleApp.more.contacts.successMessage"))
            } else {
                if vm.state == .hasError {
                    Text(localizedString("goldenSampleApp.more.contacts.errorMessage"))
                        .foregroundStyle(.red)
                }
                Text(localizedString("goldenSampleApp.more.contacts.nameLabel"))
                    .padding([.top], 10)
                TextField(localizedString("goldenSampleApp.more.contacts.namePlaceholder"), text: $name)
                    .frame(height: 50)
                    .textFieldStyle(.roundedBorder)
                Text(localizedString("goldenSampleApp.more.contacts.accountNumberLabel"))
                TextField(localizedString("goldenSampleApp.more.contacts.accountNumberPlaceholder"), text: $accountNumber)
                    .frame(height: 50)
                    .textFieldStyle(.roundedBorder)
                    .padding([.bottom], 5)
                
                VStack(alignment: .trailing) {
                    Button {
                        vm.addContact(name: name, accountNumber: accountNumber)
                    } label: {
                        if vm.state == .loading {
                            ProgressView()
                        } else {
                            Text(localizedString("goldenSampleApp.more.contacts.submitButtonText"))
                        }
                    }.disabled(name.isEmpty || accountNumber.isEmpty || vm.state == .loading)
                        .frame(width: 200, height: 40)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .background(.blue)
                        .clipShape(Capsule())
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .padding()
    }
}

extension AddContactView {
    func localizedString(_ key: String) -> String {
        return Bundle.main.localize(key) ?? ""
    }
}
