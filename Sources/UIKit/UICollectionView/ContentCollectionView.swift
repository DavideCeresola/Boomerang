//
//  ContentCollectionView.swift
//  NewArch
//
//  Created by Stefano Mondino on 22/10/2019.
//  Copyright © 2019 Synesthesia. All rights reserved.
//
import UIKit

public protocol CollectionViewCellContained {
    func apply(_ layoutAttributes: UICollectionViewLayoutAttributes)
}

public protocol ContentCollectionViewCellType: NSObjectProtocol, WithItemViewModel {
    var internalView: UIView? { get set }
    ///Constraints between cell and inner view.
    var insetConstraints: [NSLayoutConstraint] { get set }
}

public class ContentCollectionViewCell: UICollectionViewCell, ContentCollectionViewCellType {
    
    public func configure(with viewModel: ItemViewModel) {
        (self.internalView as? WithItemViewModel)?.configure(with: viewModel)
    }
    
    public weak var internalView: UIView? {
        didSet {
            guard let view = internalView else { return }
            self.backgroundColor = .clear
            self.contentView.addSubview(view)
            self.insetConstraints = view.fitInSuperview(with: .zero)
        }
    }
    ///Constraints between cell and inner view.
    public var insetConstraints: [NSLayoutConstraint] = []
    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        (internalView as? CollectionViewCellContained)?.apply(layoutAttributes)
    }
    
    open override var canBecomeFocused: Bool {
        return internalView?.canBecomeFocused ?? super.canBecomeFocused
    }
    open override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return internalView?.preferredFocusEnvironments ?? super.preferredFocusEnvironments
    }
    open override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        return internalView?.didUpdateFocus(in:context, with: coordinator) ?? super.didUpdateFocus(in: context, with: coordinator)
    }
    
    
}
