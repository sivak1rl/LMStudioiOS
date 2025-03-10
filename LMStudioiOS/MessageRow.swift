//
//  MessageRow.swift
//  LMStudioiOS
//
//  Created by Rich Sivak on 3/10/25.
//
import SwiftUI

// MARK: - MessageRow View

struct MessageRow: View {
    var message: ChatMessage
    
    var body: some View {
        HStack {
            if message.role == "user" {
                Spacer()
                Text(message.content)
                    .padding()
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(8)
                    .padding(.horizontal)
            } else {
                Text(message.content)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .padding(.horizontal)
                Spacer()
            }
        }
    }
}

