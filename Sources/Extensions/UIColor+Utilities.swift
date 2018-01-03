import UIKit



public extension UIColor {
  /// Takes the receiver, cranks it's brightness and saturation up, and makes the hue slightly brighter. Reds will become a little orange. Oranges will become a little yellow, &c.
  func vibrant() -> UIColor {
    let (hue, _, _, alpha) = hsba()
    let counterClockwiseHue = fmod(hue + 0.1, 1.0)
    return UIColor(hue: counterClockwiseHue, saturation: 1, brightness: 1, alpha: alpha)
  }
  
  
  /// Returns the inverted color of the receiver.
  func inverted() -> UIColor {
    let (r, g, b, a) = rgba()
    return UIColor(red: 1.0 - r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
  }
  
  
  /// Returns a darker version of the receiver.
  func darker() -> UIColor {
    return shiftBrightness(by: -0.1)
  }
  
  
  /// Returns a lighter version of the receiver.
  func lighter() -> UIColor {
    return shiftBrightness(by: 0.1)
  }
}



private extension UIColor {
  func shiftBrightness(by amount: CGFloat) -> UIColor {
    let (h, s, b, a) = hsba()
    let newB = min(1, max(0, b + amount))
    
    return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
  }
  
  
  func hsba() -> (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0
    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
    
    return (h: hue, s: saturation, b: brightness, a: alpha)
  }
  
  
  func rgba() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    return (r: red, g: green, b: blue, a: alpha)
  }
}
