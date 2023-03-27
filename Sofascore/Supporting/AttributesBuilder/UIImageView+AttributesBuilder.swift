import UIKit

public extension UIImageView {

    @discardableResult
    func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }

    @discardableResult
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }

    @discardableResult
    func transform(_ transform: CGAffineTransform) -> Self {
        self.transform = transform
        return self
    }

    @discardableResult
    func rotatedBy(_ angle: CGFloat) -> Self {
        return self.transform(CGAffineTransform(rotationAngle: angle))
    }
}
