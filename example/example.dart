/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project.
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user_command/user_command.dart';

void main() {
  return runApp(App());
}

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
);

final ThemeData lightTheme =
    ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue);

const List<IconData> numberedIcons = [
  Icons.looks_one,
  Icons.looks_two,
  Icons.looks_3,
  Icons.looks_4,
  Icons.looks_5,
  Icons.looks_6
];

List<Command> createExampleCommands(BuildContext context) => [
      Command(
          name: "Example without icon",
          action: () {
            showSnackBar(context, 'You selected: Example without icon');
          }),
      Command.dynamic(
          name: () => "Sometimes visible example",
          icon: () => Icons.casino,
          visible: () => Random().nextBool(),
          action: () {
            showSnackBar(context, 'You selected: Sometimes visible example');
          }),
      for (int index = 0; index < 6; index++)
        Command(
            name: "Example ${index + 1}",
            icon: numberedIcons[index],
            action: () {
              showSnackBar(context, 'You selected: Example ${index + 1}');
            }),
    ];

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Page _page = WelcomePage();

  set page(Page newPage) {
    setState(() {
      _page = newPage;
    });
  }

  ThemeData _theme = lightTheme;

  ThemeData get theme => _theme;

  set theme(ThemeData newTheme) {
    setState(() {
      _theme = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
          appBar: AppBar(title: Text('user_command ${_page.name}')),
          drawer: DrawerMenu(this),
          body: _page),
    );
  }
}

abstract class Page extends StatelessWidget {
  String get name;
}

class WelcomePage extends Page {
  @override
  String get name => "examples";

  @override
  Widget build(BuildContext context) => Center(
          child: Text(
        'Welcome the user_command package examples.\n\n'
        'Please select something from the menu...',
        style: TextStyle(fontSize: 20),
      ));
}

class TextButtonPage extends Page {
  @override
  String get name => "text button example";

  @override
  Widget build(BuildContext context) => Center(
          child: CommandTextButton(
        Command(
            name: "Text Button",
            icon: Icons.thumb_up,
            action: () {
              showSnackBar(context, 'You have clicked on the text button');
            }),
      ));
}

class ElevatedButtonPage extends Page {
  @override
  String get name => "elevated button example";

  @override
  Widget build(BuildContext context) => Center(
          child: CommandElevatedButton(
        Command(
            name: "Elevated Button",
            icon: Icons.thumb_up,
            action: () {
              showSnackBar(context, 'You have clicked on the elevated button');
            }),
      ));
}

class PopupMenuPage extends Page {
  @override
  String get name => "popup menu example";

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: Text('Click me to open the popup menu'),
      onPressed: () {
        CommandPopupMenu(context, createExampleCommands(context),
            title: "Popup Menu");
      },
    ));
  }
}

class OutlinedButtonPage extends Page {
  @override
  String get name => "outlined button example";

  @override
  Widget build(BuildContext context) => Center(
          child: CommandOutlinedButton(
        Command(
            name: "Outlined Button",
            icon: Icons.thumb_up,
            action: () {
              showSnackBar(context, 'You have clicked on the outlined button');
            }),
      ));
}

class ToolbarPage extends Page {
  @override
  String get name => "toolbar example";

  @override
  Widget build(BuildContext context) =>
      Center(child: CommandToolbar(createExampleCommands(context)));
}

class DrawerMenu extends StatelessWidget {
  final _AppState _appState;

  DrawerMenu(this._appState);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(title: Text('Menu')),
        body: ListView(
          // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              //TODO replace with CommandTile's
              if (_appState.theme == lightTheme)
                ListTile(
                  title: Text('Switch to dark theme'),
                  leading: Icon(Icons.dark_mode),
                  onTap: () {
                    _appState.theme = darkTheme;
                    closeMenu(context);
                  },
                ),
              if (_appState.theme == darkTheme)
                ListTile(
                  title: Text('Switch to light theme'),
                  leading: Icon(Icons.light_mode),
                  onTap: () {
                    _appState.theme = lightTheme;
                    closeMenu(context);
                  },
                ),
              ListTile(
                title: Text('TextButton'),
                leading: Icon(Icons.book_outlined), //TODO
                onTap: () {
                  _appState.page = TextButtonPage();
                  closeMenu(context);
                },
              ),
              ListTile(
                title: Text('ElevatedButton'),
                leading: Icon(Icons.book_outlined), //TODO
                onTap: () {
                  _appState.page = ElevatedButtonPage();
                  closeMenu(context);
                },
              ),
              ListTile(
                title: Text('OutlinedButton'),
                leading: Icon(Icons.book_outlined), //TODO
                onTap: () {
                  _appState.page = OutlinedButtonPage();
                  closeMenu(context);
                },
              ),
              ListTile(
                title: Text('PopUpMenu'),
                leading: Icon(Icons.auto_graph), //TODO
                onTap: () {
                  _appState.page = PopupMenuPage();
                  closeMenu(context);
                },
              ),
              ListTile(
                title: Text('Toolbar'),
                leading: Icon(Icons.book_outlined), //TODO
                onTap: () {
                  _appState.page = ToolbarPage();
                  closeMenu(context);
                },
              ),
            ]),
      ),
    );
  }
}

closeMenu(BuildContext context) {
  try {
    Navigator.pop(context);
  } catch (e) {
    // failed: not the end of the world.
  }
}

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
