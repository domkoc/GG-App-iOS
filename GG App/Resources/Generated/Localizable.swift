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
      internal static let ready = Strings.tr("Localizable", "GameView.Buttons.Ready", fallback: "Start!")
    }
    internal enum Labels {
      /// The game has ended. Your score is: %@
      internal static func gameEnded(_ p1: Any) -> String {
        return Strings.tr("Localizable", "GameView.Labels.GameEnded", String(describing: p1), fallback: "The game has ended. Your score is: %@")
      }
      /// The game is loading, please wait...
      internal static let loading = Strings.tr("Localizable", "GameView.Labels.Loading", fallback: "The game is loading, please wait...")
      /// The game has loaded. Are you ready?
      internal static let readyDescription = Strings.tr("Localizable", "GameView.Labels.ReadyDescription", fallback: "The game has loaded. Are you ready?")
      /// Score
      internal static let scoreboard = Strings.tr("Localizable", "GameView.Labels.Scoreboard", fallback: "Score")
    }
  }
  internal enum LobbyView {
    internal enum Error {
      /// Error! Please try again.
      internal static let unknown = Strings.tr("Localizable", "LobbyView.Error.unknown", fallback: "Error! Please try again.")
    }
    internal enum Host {
      internal enum Buttons {
        /// Start game!
        internal static let start = Strings.tr("Localizable", "LobbyView.Host.Buttons.Start", fallback: "Start game!")
      }
      internal enum Labels {
        /// The lobby id is:
        internal static let lobbyId = Strings.tr("Localizable", "LobbyView.Host.Labels.LobbyId", fallback: "The lobby id is:")
      }
    }
    internal enum Join {
      internal enum Buttons {
        /// Join lobby!
        internal static let join = Strings.tr("Localizable", "LobbyView.Join.Buttons.Join", fallback: "Join lobby!")
      }
      internal enum Inputs {
        /// id here
        internal static let lobbyId = Strings.tr("Localizable", "LobbyView.Join.Inputs.LobbyId", fallback: "id here")
        /// username here
        internal static let username = Strings.tr("Localizable", "LobbyView.Join.Inputs.Username", fallback: "username here")
      }
      internal enum Labels {
        /// Enter lobby id:
        internal static let lobbyId = Strings.tr("Localizable", "LobbyView.Join.Labels.LobbyId", fallback: "Enter lobby id:")
        /// Enter username:
        internal static let username = Strings.tr("Localizable", "LobbyView.Join.Labels.Username", fallback: "Enter username:")
      }
    }
    internal enum Labels {
      /// Multiplayer lobby
      internal static let title = Strings.tr("Localizable", "LobbyView.Labels.Title", fallback: "Multiplayer lobby")
    }
  }
  internal enum MapView {
    internal enum Buttons {
      /// Done
      internal static let done = Strings.tr("Localizable", "MapView.Buttons.Done", fallback: "Done")
    }
  }
  internal enum MultiplayerView {
    internal enum Buttons {
      /// Play!
      internal static let play = Strings.tr("Localizable", "MultiplayerView.Buttons.Play", fallback: "Play!")
    }
    internal enum Labels {
      /// In multiplayer mode you play with others and get points according to the distance of your answer from the correct location
      internal static let description = Strings.tr("Localizable", "MultiplayerView.Labels.Description", fallback: "In multiplayer mode you play with others and get points according to the distance of your answer from the correct location")
      /// Multiplayer
      internal static let title = Strings.tr("Localizable", "MultiplayerView.Labels.Title", fallback: "Multiplayer")
    }
  }
  internal enum ScoreboardView {
    /// Scoreboard
    internal static let navigationTitle = Strings.tr("Localizable", "ScoreboardView.NavigationTitle", fallback: "Scoreboard")
    internal enum Labels {
      /// Connection lost. Please try again!
      internal static let noConnection = Strings.tr("Localizable", "ScoreboardView.Labels.NoConnection", fallback: "Connection lost. Please try again!")
      /// No high scores yet!
      internal static let noHighScores = Strings.tr("Localizable", "ScoreboardView.Labels.NoHighScores", fallback: "No high scores yet!")
      /// No score
      internal static let noScore = Strings.tr("Localizable", "ScoreboardView.Labels.NoScore", fallback: "No score")
      /// Anonymous
      internal static let noUsername = Strings.tr("Localizable", "ScoreboardView.Labels.NoUsername", fallback: "Anonymous")
    }
  }
  internal enum SingleplayerView {
    internal enum Buttons {
      /// Play!
      internal static let play = Strings.tr("Localizable", "SingleplayerView.Buttons.Play", fallback: "Play!")
    }
    internal enum Labels {
      /// In singleplayer mode you play alone and get points according to the distance of your answer from the correct location
      internal static let description = Strings.tr("Localizable", "SingleplayerView.Labels.Description", fallback: "In singleplayer mode you play alone and get points according to the distance of your answer from the correct location")
      /// Singleplayer
      internal static let title = Strings.tr("Localizable", "SingleplayerView.Labels.Title", fallback: "Singleplayer")
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
