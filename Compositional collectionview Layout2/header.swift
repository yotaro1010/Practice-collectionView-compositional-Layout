//
//  header.swift
//  Compositional collectionview Layout2
//
//  Created by Yotaro Ito on 2021/03/13.
//

import Foundation
import UIKit
class Header: UICollectionReusableView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        label.text = "Categories"
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
