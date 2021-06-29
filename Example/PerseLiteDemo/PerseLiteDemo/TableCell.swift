import Foundation
import UIKit

public struct TableCell {
            
    public let label: String
    public let value: String
    
    init(
        _ label: String,
        _ value: String
    ) {
        self.label = label
        self.value = value
    }
    
    init(
        _ label: String,
        _ value: Int
    ) {
        self.label = label
        self.value = "\(value)"
    }
    
    init(
        _ label: String,
        _ value: Float
    ) {
        self.label = label
        self.value = "\(value)"
    }
    
    init(_ label: String) {
        self.label = label
        self.value = ""
    }
}
