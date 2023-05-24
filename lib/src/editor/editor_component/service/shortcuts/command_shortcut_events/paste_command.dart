import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_editor/src/infra/clipboard.dart';
import 'package:flutter/material.dart';

/// Paste.
///
/// - support
///   - desktop
///   - web
///
final CommandShortcutEvent pasteCommand = CommandShortcutEvent(
  key: 'paste the content',
  command: 'ctrl+v',
  macOSCommand: 'cmd+v',
  handler: _pasteCommandHandler,
);

CommandShortcutEventHandler _pasteCommandHandler = (editorState) {
  if (PlatformExtension.isMobile) {
    assert(false, 'pasteCommand is not supported on mobile platform.');
    return KeyEventResult.ignored;
  }

  var selection = editorState.selection;
  if (selection == null) {
    return KeyEventResult.ignored;
  }

  // delete the selection first.
  if (!selection.isCollapsed) {
    editorState.deleteSelection(selection);
  }

  // fetch selection again.
  selection = editorState.selection;
  if (selection == null) {
    return KeyEventResult.skipRemainingHandlers;
  }
  assert(selection.isCollapsed);

  // TODO: paste the rich text.
  () async {
    final data = await AppFlowyClipboard.getData();
    if (data.html != null) {
      // ...
    }
    if (data.text != null) {
      handlePastePlainText(editorState, data.text!);
    }
  }();

  return KeyEventResult.handled;
};
