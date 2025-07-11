//
//  AppSettings.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 19.02.2024.
//

import Combine
import SwiftUI

final class AppSettings: ObservableObject {
  @Published var notesOrder: NotesOrder
  @Published var appTheme: AppTheme

  private var cancellables: Set<AnyCancellable> = []

  init() {
    notesOrder = NotesOrder(rawValue: UserDefaults.standard.integer(forKey: "notes_order")) ?? .reversed
    appTheme = AppTheme(rawValue: UserDefaults.standard.string(forKey: "app_theme") ?? "summer") ?? .summer
    setupBindings()
  }

  private func setupBindings() {
    $notesOrder.sink { order in
      UserDefaults.standard.set(order.rawValue, forKey: "notes_order")
    }
    .store(in: &cancellables)

    $appTheme.sink { [weak self] theme in
      UserDefaults.standard.set(theme.rawValue, forKey: "app_theme")
      self?.changeAppIconWithoutAlert(theme)
    }
    .store(in: &cancellables)
  }

  private func changeAppIcon(_ theme: AppTheme) {
    DispatchQueue.main.async {
      let iconName: String
      switch theme {
      case .spring: iconName = "SpringAppIcon"
      case .summer: iconName = "SummerAppIcon"
      case .autumn: iconName = "AutumnAppIcon"
      case .winter: iconName = "WinterAppIcon"
      }

      UIApplication.shared.setAlternateIconName(iconName) { error in
        print("App icon changing error: \(error?.localizedDescription ?? "Undefined error")")
      }
    }
  }

  private func changeAppIconWithoutAlert(_ theme: AppTheme) {
    if UIApplication.shared.responds(to: #selector(getter: UIApplication.supportsAlternateIcons)) && UIApplication.shared.supportsAlternateIcons { // Mark 1

      let iconName: String
      switch theme {
      case .spring: iconName = "SpringAppIcon"
      case .summer: iconName = "SummerAppIcon"
      case .autumn: iconName = "AutumnAppIcon"
      case .winter: iconName = "WinterAppIcon"
      }

      typealias setAlternateIconNameClosure = @convention(c) (NSObject, Selector, NSString?, @escaping (NSError) -> ()) -> () // Mark 2.

      let selectorString = "_setAlternateIconName:completionHandler:" // Mark 3

      let selector = NSSelectorFromString(selectorString) // Mark 3
      let imp = UIApplication.shared.method(for: selector) // Mark 4
      let method = unsafeBitCast(imp, to: setAlternateIconNameClosure.self) // Mark 5
      method(UIApplication.shared, selector, iconName as NSString?, { _ in }) // Mark 6
    }
  }

  enum NotesOrder: Int, CaseIterable {
    case reversed, forwarded
  }

  enum AppTheme: String, CaseIterable {
    case spring, summer, autumn, winter

    var name: String {
      switch self {
      case .spring: String(localized: "Spring")
      case .summer: String(localized: "Summer")
      case .autumn: String(localized: "Autumn")
      case .winter: String(localized: "Winter")
      }
    }

    var image: Image {
      switch self {
      case .spring: Image(.landscapeSpring)
      case .summer: Image(.landscapeSummer)
      case .autumn: Image(.landscapeAutumn)
      case .winter: Image(.landscapeWinter)
      }
    }
    
    var backgroundColor: Color {
      switch self {
      case .spring: SpringColors.background
      case .summer: SummerColors.background
      case .autumn: AutumnColors.background
      case .winter: WinterColors.background
      }
    }
    
    var primaryContainerColor: Color {
      switch self {
      case .spring: SpringColors.primaryContrainer
      case .summer: SummerColors.primaryContrainer
      case .autumn: AutumnColors.primaryContrainer
      case .winter: WinterColors.primaryContrainer
      }
    }
    
    var onPrimaryContainerColor: Color {
      switch self {
      case .spring: SpringColors.onPrimaryContrainer
      case .summer: SummerColors.onPrimaryContrainer
      case .autumn: AutumnColors.onPrimaryContrainer
      case .winter: WinterColors.onPrimaryContrainer
      }
    }

    var onSecondaryContainerColor: Color {
      switch self {
      case .spring: SpringColors.onSecondaryContrainer
      case .summer: SummerColors.onSecondaryContrainer
      case .autumn: AutumnColors.onSecondaryContrainer
      case .winter: WinterColors.onSecondaryContrainer
      }
    }

    var noteDateRectangleColor: Color {
      switch self {
      case .spring: SpringColors.dateBackground
      case .summer: SummerColors.dateBackground
      case .autumn: AutumnColors.dateBackground
      case .winter: WinterColors.dateBackground
      }
    }

    var newNoteButtonBackgroundColor: Color {
      switch self {
      case .spring: SpringColors.newNoteButtonContainer
      case .summer: SummerColors.newNoteButtonContainer
      case .autumn: AutumnColors.newNoteButtonContainer
      case .winter: WinterColors.newNoteButtonContainer
      }
    }
  }
}

protocol Colors {
  static var background: Color { get }
  static var primaryContrainer: Color { get }
  static var onPrimaryContrainer: Color { get }
  static var onSecondaryContrainer: Color { get }
  static var dateBackground: Color { get }
  static var newNoteButtonContainer: Color { get }
}

enum SpringColors: Colors {
  static var background: Color { Color(.springBackground) }
  static var primaryContrainer: Color { Color(.springPrimaryContainer) }
  static var onPrimaryContrainer: Color { Color(.springOnPrimaryContainer) }
  static var onSecondaryContrainer: Color { Color(.springOnSecondaryContainer) }
  static var dateBackground: Color { Color(.springDateBackground) }
  static var newNoteButtonContainer: Color { Color(.springNewNoteButtonContainer) }
}

enum SummerColors: Colors {
  static var background: Color { Color(.summerBackground) }
  static var primaryContrainer: Color { Color(.summerPrimaryContainer) }
  static var onPrimaryContrainer: Color { Color(.summerOnPrimaryContainer) }
  static var onSecondaryContrainer: Color { Color(.summerOnSecondaryContainer) }
  static var dateBackground: Color { Color(.summerDateBackground) }
  static var newNoteButtonContainer: Color { Color(.summerNewNoteButtonContainer) }
}

enum AutumnColors: Colors {
  static var background: Color { Color(.autumnBackground) }
  static var primaryContrainer: Color { Color(.autumnPrimaryContainer) }
  static var onPrimaryContrainer: Color { Color(.autumnOnPrimaryContainer) }
  static var onSecondaryContrainer: Color { Color(.autumnOnSecondaryContainer) }
  static var dateBackground: Color { Color(.autumnDateBackground) }
  static var newNoteButtonContainer: Color { Color(.autumnNewNoteButtonContainer) }
}

enum WinterColors: Colors {
  static var background: Color { Color(.winterBackground) }
  static var primaryContrainer: Color { Color(.winterPrimaryContainer) }
  static var onPrimaryContrainer: Color { Color(.winterOnPrimaryContainer) }
  static var onSecondaryContrainer: Color { Color(.winterOnSecondaryContainer) }
  static var dateBackground: Color { Color(.winterDateBackground) }
  static var newNoteButtonContainer: Color { Color(.winterNewNoteButtonContainer) }
}
