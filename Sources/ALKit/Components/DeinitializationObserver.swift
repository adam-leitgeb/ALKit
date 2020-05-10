//
//  DeinitializationObserver.swift
//  
//
//  Created by Adam Leitgeb on 19/02/2020.
//

import Foundation

public class DeinitializationObserver {

    // MARK: - Properties

    let execute: () -> Void

    // MARK: - Initialization

    init(execute: @escaping () -> Void) {
        self.execute = execute
    }

    deinit {
        execute()
    }
}

// We're using objc associated objects to have this `DeinitializationObserver` stored inside the protocol extension
private struct AssociatedKeys {
    static var DeinitializationObserver = "DeinitializationObserver"
}

// Protocol for any object that implements this logic
public protocol ObservableDeinitialization: AnyObject {
    func onDeinit(_ execute: @escaping () -> Void)
}

extension ObservableDeinitialization {

    /// This stores the `DeinitializationObserver`. It's fileprivate so you
    /// cannot interfere with this outside. Also we're using a strong retain
    /// which will ensure that the `DeinitializationObserver` is deinitialized
    /// at the same time as your object.
    fileprivate var deinitializationObserver: DeinitializationObserver {
        get {
            guard let observer = objc_getAssociatedObject(self, &AssociatedKeys.DeinitializationObserver) as? DeinitializationObserver else {
                fatalError("Unable to get DeinitializationObserver")
            }
            return observer
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.DeinitializationObserver,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    /// This is what you call to add a block that should execute on `deinit`
    public func onDeinit(_ execute: @escaping () -> Void) {
        deinitializationObserver = DeinitializationObserver(execute: execute)
    }
}
