// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum Strings {

  public enum Todo {
    public enum Edit {
      /// Edit
      public static let title = Strings.tr("Localizable", "Todo.Edit.title")
      public enum Title {
        public enum Button {
          /// Save
          public static let save = Strings.tr("Localizable", "Todo.Edit.title.button.save")
        }
      }
    }
    public enum List {
      /// What do you have to do?
      public static let prompt = Strings.tr("Localizable", "Todo.List.prompt")
      /// Welcome %@
      public static func title(_ p1: Any) -> String {
        return Strings.tr("Localizable", "Todo.List.title", String(describing: p1))
      }
      public enum Title {
        public enum Button {
          /// New Todo
          public static let newTodo = Strings.tr("Localizable", "Todo.List.title.button.newTodo")
        }
      }
    }
  }

  public enum Welcome {
    /// Welcome! Please enter your name.
    public static let prompt = Strings.tr("Localizable", "Welcome.prompt")
    public enum Title {
      /// Log In
      public static let login = Strings.tr("Localizable", "Welcome.title.login")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
