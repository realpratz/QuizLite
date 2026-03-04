# QuizLite

A clean, responsive trivia application built with Flutter. This project fetches random multiple-choice questions from a public API (OpenTDB), tracks the user's score, and manages game states dynamically.

## Features
* **Live Data Integration:** Fetches fresh multiple-choice questions dynamically from the Open Trivia Database (OpenTDB).
* **State Management:** Fully integrated with Riverpod (`NotifierProvider`) to handle loading states, error catching, and UI redrawing efficiently.
* **Modern Custom UI:** Features a custom full-screen interface, interactive hover states, and a dynamic progress bar based on provided Figma designs.
* **Data Parsing:** Safely parses and decodes HTML entities received from the API for clean text rendering.

## Tech Stack
* **Framework:** Flutter / Dart
* **State Management:** flutter_riverpod
* **Networking:** http
* **Utilities:** html_unescape

## How to Run
1. Clone this repository.
2. Run `flutter pub get` in your terminal to install dependencies.
3. Run `flutter run -d chrome` to launch the web version, or run it on a connected mobile emulator.

## Sources
During the development of this project, the following resources were used for learning, reference, and design:

**Documentation & Guides**
* [Flutter Official Documentation](https://api.flutter.dev/index.html)
* [Dart Official Documentation](https://dart.dev/docs)
* [Riverpod Getting Started Guide](https://riverpod.dev/docs/introduction/getting_started)

**Tutorials & Architecture Reference**
* [Flutter Riverpod Tutorial Playlist](https://www.youtube.com/playlist?list=PL4cUxeGkcC9i88WGZ9eIfQUWRgPstLFLp)
* [Quiz App Tutorial](https://www.youtube.com/watch?v=VEbNXOe2O04) *(Used strictly for architectural reference; no code was copied from this source)*

**Design Inspiration**
* [Quiz App Generation (Figma Community)](https://www.figma.com/community/file/1462769986800139209/quiz-app-generation) *(Used strictly for architectural reference; only colour scheme and certain elements were used directly)*

## AI Usage Declaration
AI tooling was used in a strictly limited capacity during this project. Usage was restricted to:
1. **Debugging:** Resolving compilation errors and package dependency mismatches.
2. **UI Creation:** Assisting with complex layout structures (specifically, resolving widget constraints and nesting issues related to the linear progress slider implementation).
