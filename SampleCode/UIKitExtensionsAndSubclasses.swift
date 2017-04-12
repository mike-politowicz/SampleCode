import UIKit

extension UIButton {
    
    func animateShrinking(shrinkScale: CGFloat = 0.92) {
        UIView.beginAnimations("ScaleButton", context: nil)
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeOut)
        self.transform = CGAffineTransform(scaleX: shrinkScale, y: shrinkScale)
        UIView.commitAnimations()
    }
    
    func animateUnshrinking() {
        UIView.beginAnimations("ScaleButton", context: nil)
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeOut)
        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.commitAnimations()
    }
    
}

extension UIViewController {
    
    func embedInView(_ containerView: UIView, parentViewController: UIViewController) {
        parentViewController.addChildViewController(self)
        self.didMove(toParentViewController: parentViewController)
        containerView.addSubview(self.view)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = self.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let verticalConstraint = self.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        let widthConstraint = self.view.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1)
        let heightConstraint = self.view.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
}

extension UIView {
    
    func embedInView(_ containerView: UIView) {
        containerView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let verticalConstraint = self.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        let widthConstraint = self.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1)
        let heightConstraint = self.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
}
