//
//  SettingsProtocols.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

protocol SettingsViewProtocol: class {
    func setAdvancedViewSwitch(isOn: Bool)
    func getAdvancedViewSwitch() -> Bool
    func addGestureRecognizerForUpdateIntervalView()
    func addGestureRecognizerForNewsSourcesView()
    func showUpdateInterval()
}

protocol SettingsInteractorProtocol: class {
    var isAdvancedViewEvailable: Bool { get set }
    var updateInterval: UpdateInterval { get set }
    func updateSynchronization()
}

protocol SettingsPresenterProtocol: class {
    func configureView()
    func advancedViewSwitchValueChanged()
    func updateIntervalButtonClicked()
    func newsSourcesButtonClicked()
}

protocol SettingsRouterProtocol {
    func presentActionSheet(actions: [UIAlertAction])
    func presentNewsSourceSettingsViewController()
}

protocol SettingsConfiguratorProtocol {
    static func configure() -> UIViewController
}
