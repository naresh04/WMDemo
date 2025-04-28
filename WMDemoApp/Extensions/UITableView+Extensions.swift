//
//  UITableView+Extensions.swift
//  WMDemoApp
//
//  Created by naresh chouhan on 4/28/25.
//

import Foundation
import UIKit

extension UITableView {
    func reloadDataAsync() async {
        await MainActor.run {
            self.reloadData()
        }
    }
}
