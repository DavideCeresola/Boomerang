//
//  ItemViewModel.swift
//  Boomerang
//
//  Created by Stefano Mondino on 22/10/2019.
//  Copyright © 2019 Synesthesia. All rights reserved.
//

import Foundation

public protocol LayoutIdentifier {
    var identifierString: String { get }
}
extension String: UniqueIdentifier {
    public var stringValue: String { return self }
}

extension UUID: UniqueIdentifier {
    public var stringValue: String { return self.uuidString }
}

public protocol UniqueIdentifier {
    var stringValue: String { get }
}

public protocol ItemViewModel: AnyObject {
    var uniqueIdentifier: UniqueIdentifier { get }
    var layoutIdentifier: LayoutIdentifier { get }
}

public extension ItemViewModel {
    var uniqueIdentifier: UniqueIdentifier {
        return UUID()
    }
}

public protocol WithItemViewModel: AnyObject {
    func configure(with viewModel: ItemViewModel)
}
