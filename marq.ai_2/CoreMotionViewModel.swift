
import Foundation
import SwiftUI
import CoreMotion

class CoreMotionViewModel : NSObject, ObservableObject {

    static let shared = CoreMotionViewModel()
    
    private let manager = CMMotionActivityManager()
    private let manager2 = CMMotionManager()
    private let pedometer = CMPedometer()
    private let mot = CMDeviceMotion()
    private let altimeter = CMAltimeter()
    

    @Published var Soberness = "Sober"
    @Published var error = 0
    @Published var Col = Color.green
    
    func startUpdates() {
            
        manager2.startDeviceMotionUpdates(to: OperationQueue.main) { motion, error in
            let y = motion?.userAcceleration.y
            let x = motion?.userAcceleration.y
            if (abs(x!) > 0.15  || abs(y!) > 0.15 ){
                self.error += 1
                self.Col = Color.red
            }
            else{
                self.Col = Color.green
            }
            if self.error > 60 {
                self.Soberness = "Drunk"
            }
        }
                
                
    
    
    }

}
