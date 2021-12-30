//
//  WebViewStateModel.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/30/21.
//

import SwiftUI

@available(iOS 13.0, *)
class WebViewStateModel: ObservableObject {
    @Published var pageTitle: String = "Loading..."
    @Published var loading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var goBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var goForward: Bool = false
    @Published var reload: Bool = false
}

