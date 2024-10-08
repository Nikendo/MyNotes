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
      case .spring: Color(._7_D_9115)
      case .summer: Color(._07423_C)
      case .autumn: Color(._4_F_2423)
      case .winter: Color(.BDD_7_EE)
      }
    }

    var noteBackgroundColor: Color {
      switch self {
      case .spring: Color(.D_9_E_8_FD)
      case .summer: Color(.D_9_E_8_FD)
      case .autumn: Color(._73350_F)
      case .winter: Color(.ECEBFF)
      }
    }

    var noteTitleColor: Color {
      switch self {
      case .spring: Color(._101010)
      case .summer: Color(._101010)
      case .autumn: Color(.FFF_379)
      case .winter: Color(._101010)
      }
    }

    var noteMessageColor: Color {
      switch self {
      case .spring: Color(._333333)
      case .summer: Color(._333333)
      case .autumn: Color(.FDFFC_4)
      case .winter: Color(._333333)
      }
    }

    var noteDateColor: Color {
      switch self {
      case .spring: Color(._333333)
      case .summer: Color(._333333)
      case .autumn: Color(.FEA_017)
      case .winter: Color(._333333)
      }
    }

    var noteDateRectangleColor: Color {
      switch self {
      case .spring: Color(._98_BCEB)
      case .summer: Color(._98_BCEB)
      case .autumn: Color(.D_8001_B)
      case .winter: Color(._98_BCEB)
      }
    }

    var newNoteButtonBackgroundColor: Color {
      switch self {
      case .spring: .blue
      case .summer: .blue
      case .autumn: Color(.FFF_379)
      case .winter: .blue
      }
    }

    var newNoteButtonTintColor: Color {
      switch self {
      case .spring: .white
      case .summer: .white
      case .autumn: Color(._333333)
      case .winter: .white
      }
    }

    var navbarTintColor: Color {
      switch self {
      case .spring: .primary
      case .summer: .primary
      case .autumn: .primary
      case .winter: .primary
      }
    }
  }
}
