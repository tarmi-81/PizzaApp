//
//  CheckOutViewController.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 14/06/2023.
//

import Foundation
import UIKit

final class CheckOutViewController: UIViewController {
    var coordinator: Coordinator?
    private lazy var bottomView: ActionButton = {
        let view = ActionButton()
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.Font.bigBold
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Thank you\nfor your order!"
        return label
    }()
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.white
        view.addSubview(bottomView)
        view.addSubview(titleLabel)
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
extension CheckOutViewController: CommonViewController {
    internal func setUpContent() {
        bottomView.text = ""
    }
    internal func setUpContstrains() {
        bottomView.pinHorizontalSidesToContainer()
        bottomView.bottomAnchor(equalTo: view.bottomAnchor)
        bottomView.heightAnchor(equalTo: 85.0)
        titleLabel.pinSidesToContainer()
    }
    internal func setUpNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
}
