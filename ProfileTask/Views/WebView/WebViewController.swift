//
//  WebViewController.swift
//  ProfileTask
//
//  Created by Danil Komarov on 29.03.2024.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var webView:  WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupFrame()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
    
    private func setupFrame() {
        webView.frame = view.bounds
    }
}
