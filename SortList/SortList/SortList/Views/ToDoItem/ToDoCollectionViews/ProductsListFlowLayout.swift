//
//  ProductsListFlowLayout.swift
//  SortList
//
//  Created by mc373 on 08.04.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ProductsListFlowLayout: UICollectionViewFlowLayout {
	static let iDOfInstanse = "ListFlowLayout"

	let itemHeight: CGFloat = 50

	override init() {
		super.init()
		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupLayout()
	}

	/*
	Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
	*/
	func setupLayout() {
		minimumInteritemSpacing = 0
		minimumLineSpacing = 1
		scrollDirection = .Vertical
		iDOfInstanse = ProductsListFlowLayout.iDOfInstanse
	}

	func itemWidth() -> CGFloat {
			// swiftlint:disable:next legacy_cggeometry_functions
		return CGRectGetWidth(collectionView!.frame)
	}

	override var itemSize: CGSize {
		set {
				// swiftlint:disable:next legacy_constructor
			self.itemSize = CGSizeMake(itemWidth(), itemHeight)
		}
		get {
			// swiftlint:disable:next legacy_constructor
			return CGSizeMake(itemWidth(), itemHeight)
		}
	}

	// swiftlint:disable:next line_length
	override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
		// swiftlint:disable:next legacy_constructor
		return collectionView!.contentOffset
	}

}
