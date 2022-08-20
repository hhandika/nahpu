import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:nahpu/screens/narrative/new_narrative.dart';
import 'package:nahpu/providers/project.dart';

enum MenuSelection { newNote, pdfExport, deleteRecords, deleteAllRecords }

class Narrative extends ConsumerStatefulWidget {
  const Narrative({Key? key}) : super(key: key);

  @override
  NarrativeState createState() => NarrativeState();
}

class NarrativeState extends ConsumerState<Narrative> {
  @override
  Widget build(BuildContext context) {
    final projectUuid = ref.watch(projectUuidProvider.state).state;
    final narrativeEntries = ref.watch(narrativeEntriesProvider(projectUuid));

    final PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Narrative"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // await createNewNarrative(proj);
            },
          ),
          PopupMenuButton<MenuSelection>(
              // Callback that sets the selected popup menu item.
              onSelected: _onPopupMenuSelected,
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<MenuSelection>>[
                    const PopupMenuItem<MenuSelection>(
                      value: MenuSelection.newNote,
                      child: Text('Create a new narrative'),
                    ),
                    const PopupMenuItem<MenuSelection>(
                      value: MenuSelection.pdfExport,
                      child: Text('Export to PDF'),
                    ),
                    const PopupMenuItem<MenuSelection>(
                      value: MenuSelection.deleteRecords,
                      child: Text('Delete current record',
                          style: TextStyle(color: Colors.red)),
                    ),
                    const PopupMenuItem<MenuSelection>(
                      value: MenuSelection.deleteAllRecords,
                      child: Text('Delete all note records',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ])
        ],
      ),
      body: Center(
        child: narrativeEntries.when(
          data: (narrativeEntries) {
            return PageView.builder(
              controller: pageController,
              itemCount: narrativeEntries.length,
              itemBuilder: (context, index) {
                return Text(narrativeEntries[index].date!);
              },
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text(error.toString()),
        ),
      ),
    );
  }

  void _onPopupMenuSelected(MenuSelection item) {
    switch (item) {
      case MenuSelection.newNote:
        setState(() {});
        break;
      case MenuSelection.pdfExport:
        setState(() {});
        break;
      case MenuSelection.deleteRecords:
        setState(() {});
        break;
      case MenuSelection.deleteAllRecords:
        setState(() {});
        break;
    }
  }
}
