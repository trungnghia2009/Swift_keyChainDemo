//
//  ViewController.swift
//  keychainDemo
//
//  Created by nghiaTran16 on 20/12/2021.
//

import UIKit

struct Auth: Codable {
    let accessToken: String
    let refreshToken: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var serviceSaveTF: UITextField!
    @IBOutlet weak var accountSaveTF: UITextField!
    @IBOutlet weak var secretSaveTF: UITextField!
    
    @IBOutlet weak var serviceGetTF: UITextField!
    @IBOutlet weak var accountGetTF: UITextField!
    @IBOutlet weak var secretGetTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveAccessToken()
        saveAuth()
    }
    
    private func saveAccessToken() {
        print("Save access token...")
        let accessToken = "dummy-access-token"
        let data = Data(accessToken.utf8)
        KeychainHelper.standard.save(data, service: "access-token", account: "facebook")
    }
    
    private func readAccessToken() {
        print("Read access token...")
        let data = KeychainHelper.standard.read(service: "access-token", account: "facebook") ?? Data()
        let accessToken = String(data: data, encoding: .utf8) ?? "no result"
        print("access-token: \(accessToken)")
    }
    
    private func saveAuth() {
        let auth = Auth(accessToken: "dummy-access-token",
                        refreshToken: "dummy-refresh-token")
        KeychainHelper.standard.save(auth, service: "token", account: "domain.com")
    }
    
    private func readAuth() {
        let result = KeychainHelper.standard.read(service: "token", account: "domain.com", type: Auth.self)
        if let result = result {
            print("Auth: \(result)")
        }
    }
    
    @IBAction func didTapGetButton(_ sender: Any) {
        readAccessToken()
        readAuth()
    }
}

