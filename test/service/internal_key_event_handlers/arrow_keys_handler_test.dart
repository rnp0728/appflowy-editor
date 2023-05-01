import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../new/infra/testable_editor.dart';

void main() async {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('arrow_keys_handler.dart', () {
    testWidgets('Presses arrow right key, move the cursor from left to right',
        (tester) async {
      const text = 'Welcome to Appflowy 😁';
      final editor = tester.editor..addParagraphs(2, initialText: text);
      await editor.startTesting();

      await editor.updateSelection(
        Selection.single(path: [0], startOffset: 0),
      );

      for (var i = 0; i < text.length; i++) {
        await editor.pressLogicKey(key: LogicalKeyboardKey.arrowRight);

        if (i == text.length - 1) {
          // Wrap to next node if the cursor is at the end of the current node.
          expect(
            editor.selection,
            Selection.single(
              path: [1],
              startOffset: 0,
            ),
          );
        } else {
          final delta = editor.nodeAtPath([0])!.delta!;
          expect(
            editor.selection,
            Selection.single(
              path: [0],
              startOffset: delta.nextRunePosition(i),
            ),
          );
        }
      }

      editor.dispose();
    });
  });

//   testWidgets('Cursor up/down', (tester) async {
//     final editor = tester.editor
//       ..insertTextNode("Welcome")
//       ..insertTextNode("Welcome to AppFlowy");
//     await editor.startTesting();

//     await editor.updateSelection(
//       Selection.single(path: [1], startOffset: 19),
//     );

//     await editor.pressLogicKey(key: LogicalKeyboardKey.arrowUp);

//     expect(
//       editor.documentSelection,
//       Selection.single(path: [0], startOffset: 7),
//     );

//     await editor.pressLogicKey(key: LogicalKeyboardKey.arrowDown);

//     expect(
//       editor.documentSelection,
//       Selection.single(path: [1], startOffset: 7),
//     );
//   });

//   testWidgets('Cursor top/bottom select', (tester) async {
//     const text = 'Welcome to Appflowy';
//     final editor = tester.editor
//       ..insertTextNode(text)
//       ..insertTextNode(text)
//       ..insertTextNode(text);
//     await editor.startTesting();

//     Future<void> select(bool isTop) async {
//       await editor.pressLogicKey(
//         key: isTop ? LogicalKeyboardKey.arrowUp : LogicalKeyboardKey.arrowDown,
//         isMetaPressed: Platform.isMacOS,
//         isControlPressed: !Platform.isMacOS,
//         isShiftPressed: true,
//       );
//     }

//     await editor.updateSelection(
//       Selection.single(path: [1], startOffset: 7),
//     );

//     await select(true);

//     expect(
//       editor.documentSelection,
//       Selection(
//         start: Position(path: [1], offset: 7),
//         end: Position(path: [0]),
//       ),
//     );

//     await select(false);

//     expect(
//       editor.documentSelection,
//       Selection(
//         start: Position(path: [1], offset: 7),
//         end: Position(path: [2], offset: 19),
//       ),
//     );
//   });

//   testWidgets('Presses alt + arrow right key, move the cursor one word right',
//       (tester) async {
//     const text = 'Welcome to Appflowy';
//     final editor = tester.editor
//       ..insertTextNode(text)
//       ..insertTextNode(text);
//     await editor.startTesting();

//     await editor.updateSelection(
//       Selection.single(path: [0], startOffset: 0),
//     );

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//       isAltPressed: true,
//     );

//     expect(
//       editor.documentSelection,
//       Selection.single(
//         path: [0],
//         startOffset: 7,
//       ),
//     );

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//     );

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//       isAltPressed: true,
//     );

//     expect(
//       editor.documentSelection,
//       Selection.single(
//         path: [0],
//         startOffset: 10,
//       ),
//     );

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//     );

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//       isAltPressed: true,
//     );

//     expect(
//       editor.documentSelection,
//       Selection.single(
//         path: [0],
//         startOffset: 19,
//       ),
//     );

//     /// If the node does not exist, goRight will return
//     /// null, allowing us to test the edgecase of
//     /// move right word
//     editor.document.delete([0]);

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//       isAltPressed: true,
//     );

//     expect(
//       editor.documentSelection,
//       Selection.single(
//         path: [0],
//         startOffset: 19,
//       ),
//     );
//   });

//   testWidgets('Presses alt + arrow left key, move the cursor one word left',
//       (tester) async {
//     const text = 'Welcome to Appflowy';
//     final editor = tester.editor
//       ..insertTextNode(text)
//       ..insertTextNode(text);
//     await editor.startTesting();

//     await editor.updateSelection(
//       Selection.single(path: [0], startOffset: 19),
//     );

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//       isAltPressed: true,
//     );

//     expect(
//       editor.documentSelection,
//       Selection.single(
//         path: [0],
//         startOffset: 11,
//       ),
//     );

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//     );

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//       isAltPressed: true,
//     );

//     expect(
//       editor.documentSelection,
//       Selection.single(
//         path: [0],
//         startOffset: 8,
//       ),
//     );

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//     );

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//       isAltPressed: true,
//     );

//     expect(
//       editor.documentSelection,
//       Selection.single(
//         path: [0],
//         startOffset: 0,
//       ),
//     );

//     /// If the node does not exist, goRight will return
//     /// null, allowing us to test the edgecase of
//     /// move left word
//     editor.document.delete([0]);

//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//       isAltPressed: true,
//     );

//     expect(
//       editor.documentSelection,
//       Selection.single(
//         path: [0],
//         startOffset: 0,
//       ),
//     );
//   });

//   testWidgets(
//       'Presses arrow left/right key since selection is not collapsed and backward',
//       (tester) async {
//     await _testPressArrowKeyInNotCollapsedSelection(tester, true);
//   });

//   testWidgets(
//       'Presses arrow left/right key since selection is not collapsed and forward',
//       (tester) async {
//     await _testPressArrowKeyInNotCollapsedSelection(tester, false);
//   });

//   testWidgets('Presses arrow left/right + shift in collapsed selection',
//       (tester) async {
//     const text = 'Welcome to Appflowy';
//     final editor = tester.editor
//       ..insertTextNode(text)
//       ..insertTextNode(text);
//     await editor.startTesting();
//     const offset = 8;
//     final selection = Selection.single(path: [1], startOffset: offset);
//     await editor.updateSelection(selection);
//     for (var i = offset - 1; i >= 0; i--) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowLeft,
//         isShiftPressed: true,
//       );
//       expect(
//         editor.documentSelection,
//         selection.copyWith(
//           end: Position(path: [1], offset: i),
//         ),
//       );
//     }
//     for (var i = text.length; i >= 0; i--) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowLeft,
//         isShiftPressed: true,
//       );
//       expect(
//         editor.documentSelection,
//         selection.copyWith(
//           end: Position(path: [0], offset: i),
//         ),
//       );
//     }
//     for (var i = 1; i <= text.length; i++) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowRight,
//         isShiftPressed: true,
//       );
//       expect(
//         editor.documentSelection,
//         selection.copyWith(
//           end: Position(path: [0], offset: i),
//         ),
//       );
//     }
//     for (var i = 0; i < text.length; i++) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowRight,
//         isShiftPressed: true,
//       );
//       expect(
//         editor.documentSelection,
//         selection.copyWith(
//           end: Position(path: [1], offset: i),
//         ),
//       );
//     }
//   });

//   testWidgets(
//       'Presses arrow left/right + shift in not collapsed and backward selection',
//       (tester) async {
//     const text = 'Welcome to Appflowy';
//     final editor = tester.editor
//       ..insertTextNode(text)
//       ..insertTextNode(text);
//     await editor.startTesting();
//     const start = 8;
//     const end = 12;
//     final selection = Selection.single(
//       path: [0],
//       startOffset: start,
//       endOffset: end,
//     );
//     await editor.updateSelection(selection);
//     for (var i = end + 1; i <= text.length; i++) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowRight,
//         isShiftPressed: true,
//       );
//       expect(
//         editor.documentSelection,
//         selection.copyWith(
//           end: Position(path: [0], offset: i),
//         ),
//       );
//     }
//     for (var i = text.length - 1; i >= 0; i--) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowLeft,
//         isShiftPressed: true,
//       );
//       expect(
//         editor.documentSelection,
//         selection.copyWith(
//           end: Position(path: [0], offset: i),
//         ),
//       );
//     }
//   });

//   testWidgets(
//       'Presses arrow left/right + command in not collapsed and forward selection',
//       (tester) async {
//     const text = 'Welcome to Appflowy';
//     final editor = tester.editor
//       ..insertTextNode(text)
//       ..insertTextNode(text);
//     await editor.startTesting();
//     const start = 12;
//     const end = 8;
//     final selection = Selection.single(
//       path: [0],
//       startOffset: start,
//       endOffset: end,
//     );
//     await editor.updateSelection(selection);
//     for (var i = end - 1; i >= 0; i--) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowLeft,
//         isShiftPressed: true,
//       );
//       expect(
//         editor.documentSelection,
//         selection.copyWith(
//           end: Position(path: [0], offset: i),
//         ),
//       );
//     }
//     for (var i = 1; i <= text.length; i++) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowRight,
//         isShiftPressed: true,
//       );
//       expect(
//         editor.documentSelection,
//         selection.copyWith(
//           end: Position(path: [0], offset: i),
//         ),
//       );
//     }
//   });

//   testWidgets('Presses arrow left/right/up/down + meta in collapsed selection',
//       (tester) async {
//     await _testPressArrowKeyWithMetaInSelection(tester, true, false);
//   });

//   testWidgets(
//       'Presses arrow left/right/up/down + meta in not collapsed and backward selection',
//       (tester) async {
//     await _testPressArrowKeyWithMetaInSelection(tester, false, true);
//   });

//   testWidgets(
//       'Presses arrow left/right/up/down + meta in not collapsed and forward selection',
//       (tester) async {
//     await _testPressArrowKeyWithMetaInSelection(tester, false, false);
//   });

//   testWidgets('Presses arrow up/down + shift in not collapsed selection',
//       (tester) async {
//     const text = 'Welcome to Appflowy 😁';
//     final editor = tester.editor
//       ..insertTextNode(text)
//       ..insertTextNode(text)
//       ..insertTextNode(null)
//       ..insertTextNode(text)
//       ..insertTextNode(null)
//       ..insertTextNode(text)
//       ..insertTextNode(text);
//     await editor.startTesting();
//     final selection = Selection.single(path: [3], startOffset: 8);
//     await editor.updateSelection(selection);
//     for (int i = 0; i < 3; i++) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowUp,
//         isShiftPressed: true,
//       );
//     }
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [0], offset: 0),
//       ),
//     );
//     for (int i = 0; i < 7; i++) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowDown,
//         isShiftPressed: true,
//       );
//     }
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [6], offset: 0),
//       ),
//     );
//     for (int i = 0; i < 3; i++) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowUp,
//         isShiftPressed: true,
//       );
//     }
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [3], offset: 0),
//       ),
//     );
//   });

//   testWidgets('Presses shift + arrow down and meta/ctrl + shift + right',
//       (tester) async {
//     const text = 'Welcome to Appflowy 😁';
//     final editor = tester.editor
//       ..insertTextNode(text)
//       ..insertTextNode(text);
//     await editor.startTesting();
//     final selection = Selection.single(path: [0], startOffset: 8);
//     await editor.updateSelection(selection);
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowDown,
//       isShiftPressed: true,
//     );
//     if (Platform.isWindows || Platform.isLinux) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowRight,
//         isShiftPressed: true,
//         isControlPressed: true,
//       );
//     } else {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowRight,
//         isShiftPressed: true,
//         isMetaPressed: true,
//       );
//     }
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [1], offset: text.length),
//       ),
//     );
//   });

//   testWidgets('Presses shift + arrow up and meta/ctrl + shift + left',
//       (tester) async {
//     const text = 'Welcome to Appflowy 😁';
//     final editor = tester.editor
//       ..insertTextNode(text)
//       ..insertTextNode(text);
//     await editor.startTesting();
//     final selection = Selection.single(path: [1], startOffset: 8);
//     await editor.updateSelection(selection);
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowUp,
//       isShiftPressed: true,
//     );
//     if (Platform.isWindows || Platform.isLinux) {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowLeft,
//         isShiftPressed: true,
//         isControlPressed: true,
//       );
//     } else {
//       await editor.pressLogicKey(
//         key: LogicalKeyboardKey.arrowLeft,
//         isShiftPressed: true,
//         isMetaPressed: true,
//       );
//     }
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [0], offset: 0),
//       ),
//     );
//   });

//   testWidgets('Presses shift + alt + arrow left to select a word',
//       (tester) async {
//     const text = 'Welcome to Appflowy 😁';
//     final editor = tester.editor
//       ..insertTextNode(text)
//       ..insertTextNode(text);
//     await editor.startTesting();
//     final selection = Selection.single(path: [1], startOffset: 10);
//     await editor.updateSelection(selection);
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//       isShiftPressed: true,
//       isAltPressed: true,
//     );
//     // <to>
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [1], offset: 8),
//       ),
//     );
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//       isShiftPressed: true,
//       isAltPressed: true,
//     );
//     // < to>
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [1], offset: 7),
//       ),
//     );
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//       isShiftPressed: true,
//       isAltPressed: true,
//     );
//     // <Welcome to>
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [1], offset: 0),
//       ),
//     );
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//       isShiftPressed: true,
//       isAltPressed: true,
//     );
//     // <😁>
//     // <Welcome to>
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [0], offset: 22),
//       ),
//     );
//   });

//   testWidgets('Presses shift + alt + arrow right to select a word',
//       (tester) async {
//     const text = 'Welcome to Appflowy 😁';
//     final editor = tester.editor
//       ..insertTextNode(text)
//       ..insertTextNode(text);
//     await editor.startTesting();
//     final selection = Selection.single(path: [0], startOffset: 10);
//     await editor.updateSelection(selection);
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//       isShiftPressed: true,
//       isAltPressed: true,
//     );
//     // < >
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [0], offset: 11),
//       ),
//     );
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//       isShiftPressed: true,
//       isAltPressed: true,
//     );
//     // < Appflowy>
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [0], offset: 19),
//       ),
//     );
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//       isShiftPressed: true,
//       isAltPressed: true,
//     );
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//       isShiftPressed: true,
//       isAltPressed: true,
//     );
//     // < Appflowy 😁>
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [0], offset: 22),
//       ),
//     );
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//       isShiftPressed: true,
//       isAltPressed: true,
//     );
//     // < Appflowy 😁>
//     // <>
//     expect(
//       editor.documentSelection,
//       selection.copyWith(
//         end: Position(path: [1], offset: 0),
//       ),
//     );
//   });
// }

// Future<void> _testPressArrowKeyInNotCollapsedSelection(
//   WidgetTester tester,
//   bool isBackward,
// ) async {
//   const text = 'Welcome to Appflowy 😁';
//   final editor = tester.editor
//     ..insertTextNode(text)
//     ..insertTextNode(text);
//   await editor.startTesting();

//   final start = Position(path: [0], offset: 5);
//   final end = Position(path: [1], offset: 10);
//   final selection = Selection(
//     start: isBackward ? start : end,
//     end: isBackward ? end : start,
//   );
//   await editor.updateSelection(selection);
//   await editor.pressLogicKey(key: LogicalKeyboardKey.arrowLeft);
//   expect(editor.documentSelection?.start, start);

//   await editor.updateSelection(selection);
//   await editor.pressLogicKey(key: LogicalKeyboardKey.arrowRight);
//   expect(editor.documentSelection?.end, end);
// }

// Future<void> _testPressArrowKeyWithMetaInSelection(
//   WidgetTester tester,
//   bool isSingle,
//   bool isBackward,
// ) async {
//   const text = 'Welcome to Appflowy';
//   final editor = tester.editor
//     ..insertTextNode(text)
//     ..insertTextNode(text);
//   await editor.startTesting();
//   Selection selection;
//   if (isSingle) {
//     selection = Selection.single(
//       path: [0],
//       startOffset: 8,
//     );
//   } else {
//     if (isBackward) {
//       selection = Selection.single(
//         path: [0],
//         startOffset: 8,
//         endOffset: text.length,
//       );
//     } else {
//       selection = Selection.single(
//         path: [0],
//         startOffset: text.length,
//         endOffset: 8,
//       );
//     }
//   }
//   await editor.updateSelection(selection);
//   if (Platform.isWindows || Platform.isLinux) {
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//       isControlPressed: true,
//     );
//   } else {
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowLeft,
//       isMetaPressed: true,
//     );
//   }

//   expect(
//     editor.documentSelection,
//     Selection.single(path: [0], startOffset: 0),
//   );

//   if (Platform.isWindows || Platform.isLinux) {
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//       isControlPressed: true,
//     );
//   } else {
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowRight,
//       isMetaPressed: true,
//     );
//   }

//   expect(
//     editor.documentSelection,
//     Selection.single(path: [0], startOffset: text.length),
//   );

//   if (Platform.isWindows || Platform.isLinux) {
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowUp,
//       isControlPressed: true,
//     );
//   } else {
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowUp,
//       isMetaPressed: true,
//     );
//   }

//   expect(
//     editor.documentSelection,
//     Selection.single(path: [0], startOffset: 0),
//   );

//   if (Platform.isWindows || Platform.isLinux) {
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowDown,
//       isControlPressed: true,
//     );
//   } else {
//     await editor.pressLogicKey(
//       key: LogicalKeyboardKey.arrowDown,
//       isMetaPressed: true,
//     );
//   }

//   expect(
//     editor.documentSelection,
//     Selection.single(path: [1], startOffset: text.length),
//   );
}
