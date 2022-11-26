// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum GameView {
    internal enum Buttons {
      /// Next
      internal static let next = Strings.tr("Localizable", "GameView.Buttons.Next", fallback: "Next")
      /// Localizable.strings
      ///   GG App
      /// 
      ///   Created by Kocka Dominik Csaba on 2022. 10. 23..
      internal static let ready = Strings.tr("Localizable", "GameView.Buttons.Ready", fallback: "Ready")
    }
    internal enum Labels {
      /// The game has ended. Your score is: %@
      internal static func gameEnded(_ p1: Any) -> String {
        return Strings.tr("Localizable", "GameView.Labels.GameEnded", String(describing: p1), fallback: "The game has ended. Your score is: %@")
      }
      /// Loading...
      internal static let loading = Strings.tr("Localizable", "GameView.Labels.Loading", fallback: "Loading...")
      /// Score
      internal static let scoreboard = Strings.tr("Localizable", "GameView.Labels.Scoreboard", fallback: "Score")
    }
  }
  internal enum MapView {
    internal enum Buttons {
      /// Done
      internal static let done = Strings.tr("Localizable", "MapView.Buttons.Done", fallback: "Done")
    }
  }
  internal enum ScoreboardView {
    /// Scoreboard
    internal static let navigationTitle = Strings.tr("Localizable", "ScoreboardView.NavigationTitle", fallback: "Scoreboard")
  }
  internal enum SingleplayerView {
    internal enum Buttons {
      /// Start the game
      internal static let play = Strings.tr("Localizable", "SingleplayerView.Buttons.Play", fallback: "Start the game")
    }
  }
  internal enum WelcomeView {
    /// Welcome to GG App!
    internal static let title = Strings.tr("Localizable", "WelcomeView.Title", fallback: "Welcome to GG App!")
    internal enum Buttons {
      /// Create a new lobby
      internal static let createLobbyButton = Strings.tr("Localizable", "WelcomeView.Buttons.CreateLobbyButton", fallback: "Create a new lobby")
      /// Join an existing lobby
      internal static let joinLobbyButton = Strings.tr("Localizable", "WelcomeView.Buttons.JoinLobbyButton", fallback: "Join an existing lobby")
      /// Play Singleplayer
      internal static let singlePlayer = Strings.tr("Localizable", "WelcomeView.Buttons.SinglePlayer", fallback: "Play Singleplayer")
      /// View high scores
      internal static let viewScoreboardButton = Strings.tr("Localizable", "WelcomeView.Buttons.ViewScoreboardButton", fallback: "View high scores")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
