# Surf

## 1. Представьте, что вы работает на проекте, у которого

<p>
  <details>
    <summary>
      ...
    </summary>

- архитектура MVP;
- кеширования данных нет;
- API для обмена данных с сервером зафиксировано, спроектировано в REST стиле;
- есть экран с пагинируемым контентом, например, список товаров;

Необходимо реализовать следующую фичу: кешировать информацию на этом экране, чтобы при при следующих заходах на экран при отсутствии интернета пользователь мог увидеть ранее загруженный контент. Каким способом вы бы решили эту задачу, почему, какие сложности видите в предстоящем решении?

  </details>
</p>

Написал бы абстракцию над вызовами API, которая в случае наличия подключения сохраняет результат вызова в key-value кеш. Когда же подключение будет восстановлено, кеш будет обновлен новыми данными.

## 2. [Как бы вы сверстали данный экран?][2]

<p>
  <details>
    <summary>
      ...
    </summary>

В данном задании продемонстрируйте свои навыки работы с UIKit и его компонентами. В своем ответе обязательно укажите, что бы вы выбрали корневым контейнером и почему, какие вью создали бы, какие переиспользовали, какие важные нюансы стоит учесть.

  </details>
</p>

К сожалению, пока что не знаком с UIKit, так как решил постигать профессию через SwiftUI. Тем не менее, мне бы хотелось продемонстрировать как бы я решил эту задачу на SwiftUI. [Исходники][app-main] и [видео результата][app-video] прилагаю.

https://user-images.githubusercontent.com/56481109/215717720-cc04f235-3822-4548-aeae-ab3fa83554bf.mov

## 3. [По ссылке вы найдете небольшой фрагмент кода][3]

<p>
  <details>
    <summary>
      ...
    </summary>

Какие недочеты в нем есть, какие предложения по его рефакторингу вы бы предложили?

  </details>
</p>

Из недочетов — это некорректное отображение времени в ряде случаев, а по рефакторингу — выделил функцию парсинга секунд и убрал if-else за ненадобностью. [Результат изменений][playground] прилагаю.

```swift
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
```

## 4. [Предположим, у вас есть экран для фильтрации подборки в ленте][4]

<p>
  <details>
    <summary>
      ...
    </summary>

На экране есть ячейка таблицы UITableViewCell, которую можно увидеть на изображении ниже. В этой ячейке находится кастомная UIView с каруселью примененных фильтров - AppliedFiltersCarouselView, внутри которой лежит UICollectionView, границы которого выделены на картинке ниже красной рамкой. При тапе на ячейку - должен открываться вложенный экран, и сейчас так и происходит, если тапнуть в область, обозначенную синим кругом. А при тапе на область, обозначенную зеленым кругом - не происходит ничего. Задача - объясните, почему так происходит? И как сделать так, чтобы при тапе по области, обозначенной зеленым кругом, происходило открытие вложенного экрана, то есть тап обрабатывался бы как нажатие на ячейку в целом.

  </details>
</p>

Увы, этот вопрос вынужден оставить без ответа.

## 5. Представьте ситуацию

<p>
  <details>
    <summary>
      ...
    </summary>

Вы разработчик на крупном проекте, на котором используется open source библиотека компании, в которой вы работаете. Известно, что 3 метода из этой библиотеки работают некорректно, а в 5 других случаях описание логики в документации не соответствует реальному поведению.

Вам поставлена задача сделать фичу, которая использует 2 неработающих метода данной библиотеки, и еще 2 с некорректной документацией. Задачу необходимо выполнить в течение 6 часов.
По вашей оценке для реализации фичи требуется не менее 4 часов без учета исправлений внутри библиотеки, и времени с большой долей вероятности не хватит.

Опишите ваши действия для выполнения поставленной задачи.

  </details>
</p>

Постарался бы реализовать фичу с минимально возможным функционалом, добавив абстракций над методами библиотеки, используемыми фичой. Оставшееся время потратил бы на исправление некорректно работающих методов библиотеки, дабы избавиться от дополнительных абстракций и иметь возможность продолжить разработку фичи. В последнюю очередь обратил бы внимание на методы, в которых неверно описана логика.

<!-- // -->

[2]: https://lh6.googleusercontent.com/KC_U0n66TJKfxLt6umVQYmG8CmiZHDBF5weBxMSYb0xwSbRXNJA0H-ZKKPFyQi-m2y-EYYSI3OiANyLFmON5ooIgN_chvsOK7mdkUKPIMnBYOhw9sYFnNmry5KeGP8jbUA=w320
[3]: https://gist.github.com/chausovSurfStudio/d2b95593e5ae889ae11b5380b5697629
[4]: https://lh3.googleusercontent.com/FYSiMWqcRtPioRjdQ8uLyTlJU8HHpsJUjH0TbQnu9UDK1lZie-EzsYd6FAljRKUaSvRLqG5UisT2rvjPP6PsYQ0zbJ75yPBC2nd4QaYCIP4Kd9QnPlVzqtRSu8kP6ZZpOQ=w740

[app-main]: ./Surf/SurfApp.swift
[app-video]: ./app.mov
[playground]: ./TimeFormatter.playground/Contents.swift
