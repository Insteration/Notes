//
//  SearchResult.swift
//  Notes
//
//  Created by Artem Karmaz on 2/4/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class SearchResult: UIView {
    
    let label: UILabel = UILabel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView() {
        self.backgroundColor = UIColor.black
        self.alpha = 0.0
        
        // Configure label
        label.textAlignment = .center
        label.textColor = UIColor.white
        addSubview(label)
    }
    
    override func draw(_ rect: CGRect) {
        label.frame = self.bounds
    }
    
    //MARK: - Animation
    
    fileprivate func hideFooter() {
        UIView.animate(withDuration: 0.7) {[unowned self] in
            self.alpha = 0.0
        }
    }
    
    fileprivate func showFooter() {
        UIView.animate(withDuration: 0.7) {[unowned self] in
            self.alpha = 1.0
        }
    }
}

extension SearchResult {
    //MARK: - Public API
    
    public func setNotFiltering() {
        label.text = ""
        hideFooter()
    }
    
    public func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
        if (filteredItemCount == totalItemCount) {
            print("NO FILTERING!")
            setNotFiltering()
        } else if (filteredItemCount == 0) {
            print("FILTERED ITEM COUNT = 0")
            label.text = "No items match your query"
            showFooter()
        } else {
            print("Filtering \(filteredItemCount) of \(totalItemCount)")
            label.text = "Filtering \(filteredItemCount) of \(totalItemCount)"
            showFooter()
        }
    }
    
}
