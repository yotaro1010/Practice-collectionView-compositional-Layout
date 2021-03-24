//
//  ViewController.swift
//  Compositional collectionview Layout2
//
//  Created by Yotaro Ito on 2021/03/13.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }
        return 8
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contoller = UIViewController()
        contoller.view.backgroundColor = indexPath.section == 0 ? .yellow : .blue
        navigationController?.pushViewController(contoller, animated: true)
    }
   
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ViewController.createLayout())
        return collectionView
    }()
    
    static func createLayout() -> UICollectionViewCompositionalLayout{
        
        return UICollectionViewCompositionalLayout { (sectionNunber, env) -> NSCollectionLayoutSection? in
//            sectionNumberによってsectionごとにcellの表示の仕方を変える
//            section 0
            if sectionNunber == 0{
                let item = NSCollectionLayoutItem(layoutSize: .init(
                                                    widthDimension: .fractionalWidth(1),
                                                    heightDimension: .fractionalHeight(1)))
    //            section1のcellのspacing
                item.contentInsets.trailing = 2
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                                .init(
                                                                    widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .absolute(300)),
                                                               subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
    //            sectionのcellの動き
                section.orthogonalScrollingBehavior = .paging
                return section
                
                
            } else if sectionNunber == 1{
//                section 1
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25),
                                                                    heightDimension: .absolute(150)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16

                let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                                .init(widthDimension: .fractionalWidth(1),
                                                                      heightDimension: .estimated(500)),
                                                               subitems: [item])
//                group.contentInsets.leading = 16
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
//                sectionのheaderなどを追加できる
                section.boundarySupplementaryItems = [
                    .init(layoutSize:
                            .init(widthDimension: .fractionalWidth(1),
                                  heightDimension: .absolute(50)),
                          elementKind: categoryHeaderId,
                          alignment: .topLeading)
                ]
                return section
            } else if sectionNunber == 2{
                let item = NSCollectionLayoutItem.init(layoutSize:
                                                        .init(widthDimension: .fractionalWidth(1),
                                                              heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 32
                let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                                .init(widthDimension: .fractionalWidth(0.8),
//                                                                      0.8にすることで隠れているcellを見せれる
                                                                      heightDimension: .absolute(125)),
                                                               subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                    heightDimension: .absolute(300)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
    
                let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                                .init(widthDimension: .fractionalWidth(1),
                                                                      heightDimension: .estimated(1000)),
                                                               subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top:  32, leading: 16, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [
                    .init(layoutSize:
                            .init(widthDimension: .fractionalWidth(1),
                                  heightDimension: .absolute(50)),
                          elementKind: categoryHeaderId,
                          alignment: .topLeading)]
                return section
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId , for: indexPath)

        return header
    }
    let headerId = "headerId"
    static let categoryHeaderId = "categoryHeaderId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.register(Header.self,
                                forSupplementaryViewOfKind: ViewController.categoryHeaderId,
                                withReuseIdentifier: headerId)
        collectionView.backgroundColor = .white
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

}


