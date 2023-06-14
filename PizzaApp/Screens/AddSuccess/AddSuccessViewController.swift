//
//  AddSuccessScreenScreenController.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 12/06/2023.
//

import Foundation
import UIKit

final class AddSuccessViewController: UIViewController {
    var coordinator: Coordinator?
    private lazy var addSuccessLabel: ActionButton = {
        let view = ActionButton()
        return view
    }()
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.white
        view.addSubview(addSuccessLabel)
        setUpNavigationBar()
        setUpContstrains()
        setUpContent()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if let mainCoordinator = coordinator as? MainCoordinator {
                self.navigationController?.isNavigationBarHidden = false
                mainCoordinator.closeViewConntroller()
            }
        }
    }
}
extension AddSuccessViewController: CommonViewController {
    internal func setUpContent() {
        addSuccessLabel.text = "ADDED TO CART"
    }
    internal func setUpContstrains() {
        addSuccessLabel.pinHorizontalSidesToContainer()
        addSuccessLabel.topAnchor(equalTo: view.safeAreaLayoutGuide.topAnchor)
        addSuccessLabel.heightAnchor(equalTo: 85.0)
    }
    internal func setUpNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
}
