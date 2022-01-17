//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by 이재웅 on 2022/01/17.
//

import Foundation
import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
