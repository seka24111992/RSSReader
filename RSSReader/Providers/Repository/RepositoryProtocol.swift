//
//  RepositoryProtocol.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 24.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

public protocol RepositoryProtocol: NSObjectProtocol {
    associatedtype T
    func fetchFromRepository(for userId: Int) -> FetchResult<[T]>
    func fetchFromRepository(fetchString: String) -> FetchResult<[T]>
    func saveToRepository(for userId: Int, fetchables: [T], completionHandler: @escaping (FetchResult<[T]>) -> Void)
}
