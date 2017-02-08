import Foundation

extension NSObject {
    
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
    
    var className: String {
        return type(of: self).className
    }
    
}
