import Foundation
import XCTest

public final class TimeFormatter {
  public init() {}

  private func formatForTimer(with seconds: Int) -> String {
    let (hours, minutes, seconds) = parse(seconds)
    return hours > .zero
      ? String(format: "%02d:%02d:%02d", hours, minutes, seconds)
      : String(format: "%02d:%02d", minutes, seconds)
  }

  private func formatForAlert(with seconds: Int) -> String {
    let (hours, minutes, seconds) = parse(seconds)
    if hours > .zero && seconds > .zero {
      return String(format: "%d ч. %d мин. %d сек.", hours, minutes, seconds)
    }
    if hours > .zero && minutes > .zero {
      return String(format: "%d ч. %d мин.", hours, minutes)
    }
    if hours > .zero {
      return String(format: "%d ч.", hours)
    }
    if minutes > .zero && seconds > .zero {
      return String(format: "%d мин. %d сек.", minutes, seconds)
    }
    if minutes > .zero {
      return String(format: "%d мин.", minutes)
    }
    return String(format: "%d сек.", seconds)
  }

  private func parse(_ seconds: Int) -> (Int, Int, Int) {
    let hours = seconds / 3600
    let minutes = (seconds - hours * 3600) / 60
    let seconds = seconds % 60
    return (hours, minutes, seconds)
  }

  public func format(_ seconds: Int, isShortFormat: Bool) -> String {
    isShortFormat
      ? formatForTimer(with: seconds)
      : formatForAlert(with: seconds)
  }
}

final class TimeFormatterTests: XCTestCase {
  final class Observer: NSObject, XCTestObservation {
    func testCase(
      _ testCase: XCTestCase,
      didFailWithDescription description: String,
      inFile filePath: String?,
      atLine lineNumber: Int
    ) {
      assertionFailure(description, line: UInt(lineNumber))
    }
  }

  static func run() {
    let observer = Observer()
    XCTestObservationCenter.shared.addTestObserver(observer)
    TimeFormatterTests.defaultTestSuite.run()
  }

  let formatter = TimeFormatter()

  // MARK: Tests

  func test_timer() {
    XCTAssertEqual(formatter.format(59, isShortFormat: true), "00:59")
    XCTAssertEqual(formatter.format(60, isShortFormat: true), "01:00")
    XCTAssertEqual(formatter.format(61, isShortFormat: true), "01:01")
    XCTAssertEqual(formatter.format(3600, isShortFormat: true), "01:00:00")
    XCTAssertEqual(formatter.format(3659, isShortFormat: true), "01:00:59")
    XCTAssertEqual(formatter.format(3660, isShortFormat: true), "01:01:00")
    XCTAssertEqual(formatter.format(3661, isShortFormat: true), "01:01:01")
  }

  func test_alert() {
    XCTAssertEqual(formatter.format(59, isShortFormat: false), "59 сек.")
    XCTAssertEqual(formatter.format(60, isShortFormat: false), "1 мин.")
    XCTAssertEqual(formatter.format(61, isShortFormat: false), "1 мин. 1 сек.")
    XCTAssertEqual(formatter.format(3600, isShortFormat: false), "1 ч.")
    XCTAssertEqual(formatter.format(3659, isShortFormat: false), "1 ч. 0 мин. 59 сек.")
    XCTAssertEqual(formatter.format(3660, isShortFormat: false), "1 ч. 1 мин.")
    XCTAssertEqual(formatter.format(3661, isShortFormat: false), "1 ч. 1 мин. 1 сек.")
  }
}

TimeFormatterTests.run()
