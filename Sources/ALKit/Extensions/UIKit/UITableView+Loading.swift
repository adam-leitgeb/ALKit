//
//  UITableView+Loading.swift
//
//
//  Created by Adam Leitgeb on 15/09/2019.
//

import UIKit

public extension UITableView {
    func beginRefreshing() {
        guard let refreshControl = refreshControl, !refreshControl.isRefreshing else {
            return
        }
        
        refreshControl.beginRefreshing()

        let contentOffset = CGPoint(x: 0, y: -refreshControl.frame.height)
        setContentOffset(contentOffset, animated: true)
    }

    func endRefreshing() {
        refreshControl?.endRefreshing()
    }
}
