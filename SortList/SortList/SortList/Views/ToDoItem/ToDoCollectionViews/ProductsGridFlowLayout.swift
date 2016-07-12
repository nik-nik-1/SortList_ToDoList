//
//  ProductsGridFlowLayout.swift
//  SortList
//
//  Created by mc373 on 08.04.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ProductsGridFlowLayout: UICollectionViewFlowLayout {

	static let iDOfInstanse = "GridFlowLayout"
	// here you can define the height of each cell
	let itemHeight: CGFloat = 100

	override init() {
		super.init()
		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupLayout()
	}

	/**
	Sets up the layout for the collectionView.
	//1pt distance between each cell
	//and 1pt distance between each row plus use a vertical layout
	*/
	func setupLayout() {
		minimumInteritemSpacing = 1
		minimumLineSpacing = 1
		scrollDirection = .Vertical
		iDOfInstanse = ProductsGridFlowLayout.iDOfInstanse
	}

	// here we define the width of each cell,
	//creating a 2 column layout.
	//In case you would create 3 columns, change the number 2 to 3
	func itemWidth() -> CGFloat {
		// swiftlint:disable:next legacy_cggeometry_functions
		return (CGRectGetWidth(collectionView!.frame)/2)-1
	}

	override var itemSize: CGSize {
		// swiftlint:disable legacy_constructor
		set {
			self.itemSize = CGSizeMake(itemWidth(), itemHeight)
		}
		get {
			return CGSizeMake(itemWidth(), itemHeight)
		}
		// swiftlint:enable legacy_constructor
	}

	// swiftlint:disable:next line_length
	override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
		return collectionView!.contentOffset
	}

}
