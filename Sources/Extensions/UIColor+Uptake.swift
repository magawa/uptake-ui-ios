import UIKit



public extension UIColor {
  /// CAT's branded color of red.
  static var catRed: UIColor {
    return UIColor(red: 169.0/255.0, green: 18.0/255.0, blue: 33.0/255.0, alpha: 1)
  }

    
  /// Color of navigation bar in Uptake's dark theme.
  static var darkBarBackground: UIColor {
    return UIColor(red: 24.0/255.0, green: 24.0/255.0, blue: 24.0/255.0, alpha: 1.0)
  }
  
  
  /// Color of backgrounds in Uptake's dark theme. I.e. the background color of a view controller's view.
  static var darkBackground: UIColor {
    return UIColor(red: 35.0/255.0, green: 35.0/255.0, blue: 35.0/255.0, alpha: 1.0)
  }
  
  
  /// Color of dark elements that will appear on top of `darkBackground`.
  static var darkForeground: UIColor {
    return UIColor(red: 52.0/255.0, green: 52.0/255.0, blue: 52.0/255.0, alpha: 1.0)
  }
  
  
  /// The color of interactive elements. I.e. buttons.
  static var activeTint: UIColor {
    return UIColor(red: 0.0/255.0, green: 162.0/255.0, blue: 187.0/255.0, alpha: 1.0)
  }
  
  
  /// The color of otherwise interactive elements that, for whatever reason, are currently inactive.
  static var disabledTint: UIColor {
    return UIColor(white: 1.0, alpha: 0.1)
  }
  
  
  /**
   If an interactive component has a separate text component displayed on top of it, this is the color the text should be when disabled.
   
   * Note: If an element is only text (i.e. a link), use `disabledTint` instead. If an element has text displayed on top of `disabledTint`, use this color to distinguish it.
   */
  static var disabledText: UIColor {
    return UIColor(white: 1.0, alpha: 0.2)
  }
}

