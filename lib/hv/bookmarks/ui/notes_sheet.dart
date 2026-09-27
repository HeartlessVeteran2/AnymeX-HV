import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/hv/bookmarks/bookmark_repository.dart';
import 'package:flutter/material.dart';

/// Private notes for the current chapter and for the whole series.
Future<void> showHvNotesSheet(
  BuildContext context, {
  required String mediaKey,
  required String chapterKey,
  required Chapter? chapter,
}) async {
  final chapterController = TextEditingController(
      text: BookmarkRepository.noteText(hvNoteKey(mediaKey, chapterKey)));
  final seriesController = TextEditingController(
      text: BookmarkRepository.noteText(hvNoteKey(mediaKey, null)));
  final chapterLabel = chapter?.number != null
      ? 'Chapter ${chapter!.formattedNumber}'
      : 'This chapter';

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheet) => Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.viewInsetsOf(sheet).bottom + 16),
      child: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(tabs: [Tab(text: chapterLabel), const Tab(text: 'Series')]),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: TabBarView(children: [
                _NoteField(controller: chapterController),
                _NoteField(controller: seriesController),
              ]),
            ),
          ],
        ),
      ),
    ),
  );

  await BookmarkRepository.saveNote(
    mediaKey: mediaKey,
    chapterKey: chapterKey,
    chapterNumber: chapter?.number,
    text: chapterController.text,
  );
  await BookmarkRepository.saveNote(
      mediaKey: mediaKey, text: seriesController.text);
  chapterController.dispose();
  seriesController.dispose();
}

class _NoteField extends StatelessWidget {
  const _NoteField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: const InputDecoration(
          hintText: 'Only you can see this. Saved when you close the sheet.',
          border: OutlineInputBorder(),
        ),
      );
}
