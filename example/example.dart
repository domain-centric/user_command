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
  Widget _page = WelcomePage();

  set page(Widget newPage) {
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
          appBar: AppBar(title: Text(pageTitle(_page.runtimeType))),
          drawer: DrawerMenu(this),
          body: _page),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
          child: Text(
        'Welcome the user_command package examples.\n\n'
        'Please select an example from the menu...',
        style: TextStyle(fontSize: 20),
      ));
}

class TextButtonExamplePage extends StatelessWidget {
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

class ElevatedButtonExamplePage extends StatelessWidget {
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

class OutlinedButtonExamplePage extends StatelessWidget {
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

class PopupMenuExamplePage extends StatelessWidget {
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

class PopupMenuButtonExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        CommandPopupMenuButton(
            iconData: Icons.more_vert,
            commands: createExampleCommands(context)),
        SizedBox(height: 48),
        CommandPopupMenuButton(
          iconData: Icons.more_vert,
          commands: createExampleCommands(context),
          anchorPosition: AnchorPosition.left,
        ),
      ],
    ));
  }
}

class PopupMenuButtonInsideTextFieldExamplePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final textFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: TextField(
          key: textFieldKey,
          controller: nameController,
          decoration: InputDecoration(
              labelText: 'Please enter your name',
              suffixIcon: CommandPopupMenuButton(
                // important: we want the popup menu to position relative to
                // the TextField by providing its global key.
                anchorWidgetKey: textFieldKey,
                // limiting the button height because its inside a TextField.
                style: CommandPopupMenuButtonStyle(
                    iconButtonStyle: CommandPopupMenuIconButtonStyle(
                        constraints: BoxConstraints(minHeight: 10))),
                iconData: Icons.more_vert,
                commands: [
                  Command(
                      name: 'Clear',
                      icon: Icons.clear,
                      action: () {
                        nameController.text = '';
                      }),
                  Command(
                      name: 'Say hallo',
                      icon: Icons.chat_bubble_outlined,
                      action: () {
                        showSnackBar(context, 'Hello ${nameController.text}!');
                      })
                ],
              )),
        ),
      ),
    );
  }
}

class ToolbarExamplePage extends StatelessWidget {
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
                onTap: () {
                  _appState.page = TextButtonExamplePage();
                  closeMenu(context);
                },
              ),

              ListTile(
                title: Text('ElevatedButton'),
                onTap: () {
                  _appState.page = ElevatedButtonExamplePage();
                  closeMenu(context);
                },
              ),
              ListTile(
                title: Text('OutlinedButton'),
                onTap: () {
                  _appState.page = OutlinedButtonExamplePage();
                  closeMenu(context);
                },
              ),
              ListTile(
                title: Text('PopUpMenu'),
                onTap: () {
                  _appState.page = PopupMenuExamplePage();
                  closeMenu(context);
                },
              ),
              ListTile(
                title: Text('PopupMenuButton'),
                onTap: () {
                  _appState.page = PopupMenuButtonExamplePage();
                  closeMenu(context);
                },
              ),
              ListTile(
                title: Text('Nested PopupMenuButton'),
                onTap: () {
                  _appState.page = PopupMenuButtonInsideTextFieldExamplePage();
                  closeMenu(context);
                },
              ),
              ListTile(
                title: Text('Toolbar'),
                onTap: () {
                  _appState.page = ToolbarExamplePage();
                  closeMenu(context);
                },
              ),
            ]),
      ),
    );
  }
}

String pageTitle(Type pageType) {
  final pageSuffix = RegExp(r"Page$");
  final beforeCapitalLetter = RegExp(r"(?=[A-Z])");
  String titleWithoutSpaces = pageType.toString().replaceAll(pageSuffix, '');
  var titleWords = titleWithoutSpaces.split(beforeCapitalLetter);
  return 'user_command   ' + titleWords.join(' ');
}

//TODO can we get rid of this?
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
