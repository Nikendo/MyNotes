//
//  HideKeyboardOnTap.swift
//  MyNotes
//

import SwiftUI

struct HideKeyboardOnTapModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.background(KeyboardDismissInstaller())
  }
}

extension View {
  func hideKeyboardOnTap() -> some View {
    modifier(HideKeyboardOnTapModifier())
  }
}

private struct KeyboardDismissInstaller: UIViewRepresentable {
  func makeCoordinator() -> Coordinator {
    Coordinator()
  }

  func makeUIView(context: Context) -> InstallerView {
    let view = InstallerView()
    view.isUserInteractionEnabled = false
    view.backgroundColor = .clear
    view.onAttach = { [weak view] in
      guard let view else { return }
      context.coordinator.installIfNeeded(from: view)
    }
    return view
  }

  func updateUIView(_ uiView: InstallerView, context: Context) {
    context.coordinator.installIfNeeded(from: uiView)
  }

  static func dismantleUIView(_ uiView: InstallerView, coordinator: Coordinator) {
    coordinator.uninstall()
  }

  final class Coordinator: NSObject, UIGestureRecognizerDelegate {
    private weak var installedView: UIView?
    private var recognizer: UITapGestureRecognizer?

    func installIfNeeded(from view: UIView) {
      guard recognizer == nil, let host = view.enclosingControllerView else { return }

      let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
      tap.cancelsTouchesInView = false
      tap.delaysTouchesBegan = false
      tap.delaysTouchesEnded = false
      tap.delegate = self
      host.addGestureRecognizer(tap)
      installedView = host
      recognizer = tap
    }

    func uninstall() {
      if let recognizer, let installedView {
        installedView.removeGestureRecognizer(recognizer)
      }
      recognizer = nil
      installedView = nil
    }

    @objc private func handleTap() {
      installedView?.endEditing(true)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
      var current: UIView? = touch.view
      while let view = current {
        if view is UITextField || view is UITextView {
          return false
        }
        current = view.superview
      }
      return true
    }

    func gestureRecognizer(
      _ gestureRecognizer: UIGestureRecognizer,
      shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
      true
    }
  }
}

private final class InstallerView: UIView {
  var onAttach: (() -> Void)?

  override func didMoveToWindow() {
    super.didMoveToWindow()
    guard window != nil else { return }
    onAttach?()
  }
}

private extension UIView {
  var enclosingControllerView: UIView? {
    var responder: UIResponder? = self
    while let current = responder {
      if let viewController = current as? UIViewController {
        return viewController.view
      }
      responder = current.next
    }
    return window
  }
}
