import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_app_exam_tk2/components/cards.dart';
import 'package:notes_app_exam_tk2/model/notes.dart';
import 'package:notes_app_exam_tk2/pages/edit.dart';
import 'package:notes_app_exam_tk2/pages/settings.dart';
import 'package:notes_app_exam_tk2/pages/view.dart';
import 'package:notes_app_exam_tk2/services/database.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, this.title, this.changeTheme});

  final String? title;
  final Function(Brightness brightness)? changeTheme;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isFlagOn = false;
  bool headerShouldHide = false;
  List<NotesModel> notesList = [];
  TextEditingController searchController = TextEditingController();

  bool isSearchEmpty = true;

  @override
  void initState() {
    super.initState();
    NotesDatabaseService.db.init();
    setNotesFromDB();
  }

  setNotesFromDB() async {
    log("Entered setNotes");
    var fetchedNotes = await NotesDatabaseService.db.getNotesFromDB();
    setState(() {
      notesList = fetchedNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          gotoEditNote(context);
        },
        label: Text('Add note'.toUpperCase()),
        icon: const Icon(Icons.add),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SettingsPage(changeTheme: widget.changeTheme),
                        ),
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.settings,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey.shade600
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
              buildHeaderWidget(context),
              buildButtonRow(),
              buildImportantIndicatorText(),
              Container(height: 32),
              ...buildNoteComponentsList(),
              GestureDetector(
                  onTap: () {
                    gotoEditNote(context);
                  },
                  child: const AddNoteCardComponent()),
              Container(height: 100)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.only(left: 16),
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      maxLines: 1,
                      onChanged: (value) {
                        handleSearch(value);
                      },
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(isSearchEmpty ? Icons.search : Icons.cancel,
                        color: Colors.grey.shade300),
                    onPressed: () {
                      cancelSearch;
                    },
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isFlagOn = !isFlagOn;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              height: 50,
              width: 50,
              curve: Curves.slowMiddle,
              decoration: BoxDecoration(
                  color: isFlagOn ? Colors.blue : Colors.transparent,
                  border: Border.all(
                    width: isFlagOn ? 2 : 1,
                    color:
                        isFlagOn ? Colors.blue.shade700 : Colors.grey.shade300,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: Icon(
                isFlagOn ? Icons.flag : Icons.flag,
                color: isFlagOn ? Colors.white : Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeaderWidget(BuildContext context) {
    return Row(
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
          margin: const EdgeInsets.only(top: 8, bottom: 32, left: 10),
          width: headerShouldHide ? 0 : 200,
          child: Text(
            'Your Notes',
            style: TextStyle(
              fontFamily: 'ZillaSlab',
              fontWeight: FontWeight.w700,
              fontSize: 36,
              color: Theme.of(context).primaryColor,
            ),
            overflow: TextOverflow.clip,
            softWrap: false,
          ),
        ),
      ],
    );
  }

  Widget testListItem(Color color) {
    return NoteCardComponent(
      noteData: NotesModel.random(),
    );
  }

  Widget buildImportantIndicatorText() {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      firstChild: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          'Only showing notes marked important'.toUpperCase(),
          style: const TextStyle(
              fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w500),
        ),
      ),
      secondChild: Container(
        height: 2,
      ),
      crossFadeState:
          isFlagOn ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  List<Widget> buildNoteComponentsList() {
    List<Widget> noteComponentsList = [];

    notesList.sort((a, b) {
      return b.date!.compareTo(a.date!);
    });

    if (searchController.text.isNotEmpty) {
      for (var note in notesList) {
        if (note.title!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            note.content!
                .toLowerCase()
                .contains(searchController.text.toLowerCase())) {
          noteComponentsList.add(
            NoteCardComponent(
              noteData: note,
              onTapAction: (notesModel) {
                openNoteToRead(notesModel);
              },
            ),
          );
        }
      }
      return noteComponentsList;
    }

    if (isFlagOn) {
      for (var note in notesList) {
        if (note.isImportant!) {
          noteComponentsList.add(NoteCardComponent(
            noteData: note,
            onTapAction: (notesModel) {
              openNoteToRead(notesModel);
            },
          ));
        }
      }
    } else {
      for (var note in notesList) {
        noteComponentsList.add(NoteCardComponent(
          noteData: note,
          onTapAction: (notesModel) {
            openNoteToRead(notesModel);
          },
        ));
      }
    }
    return noteComponentsList;
  }

  void handleSearch(String value) {
    if (value.isNotEmpty) {
      setState(() {
        isSearchEmpty = false;
      });
    } else {
      setState(() {
        isSearchEmpty = true;
      });
    }
  }

  void gotoEditNote(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotePage(
          triggerRefetch: refetchNotesFromDB,
        ),
      ),
    );
  }

  void refetchNotesFromDB() async {
    await setNotesFromDB();
  }

  openNoteToRead(NotesModel noteData) async {
    final navigator = Navigator.of(context);
    setState(() {
      headerShouldHide = true;
    });
    await Future.delayed(const Duration(milliseconds: 230), () {});

    navigator.push(
      MaterialPageRoute(
        builder: (context) => ViewNotePage(
          triggerRefetch: refetchNotesFromDB,
          currentNote: noteData,
        ),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 300), () {});

    setState(() {
      headerShouldHide = false;
    });
  }

  void cancelSearch(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      searchController.clear();
      isSearchEmpty = true;
    });
  }
}
