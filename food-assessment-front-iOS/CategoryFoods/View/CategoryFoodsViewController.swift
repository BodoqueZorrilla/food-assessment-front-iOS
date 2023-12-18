//
//  CategoryFoodsViewController.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 17/12/23.
//

import UIKit

final class CategoryFoodsViewController: UICollectionViewController {
    
    private let cellId = "cellId"
    private var viewModel: CategoryFoodViewModel?

    init(viewModel: CategoryFoodViewModel) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel?.categoryName ?? ""
        Task {
            await viewModel?.fetchCategoryFoods()
            self.collectionView.reloadData()
        }
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(CategoryFoodsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return viewModel?.categoryFoods?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                      for: indexPath) as? CategoryFoodsCollectionViewCell
        cell?.food = viewModel?.categoryFoods?[indexPath.item]
        return cell ?? UICollectionViewCell()
    }
}

extension CategoryFoodsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3 * 16) / 2
        return .init(width: width, height: width + 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
