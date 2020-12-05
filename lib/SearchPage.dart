import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tldrflutter/CommandPage.dart';

import 'AboutPage.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff002b36),
        appBar: AppBar(
          backgroundColor: Color(0xff002b36),
          title: Text("tldrflutter"),
          actions: [
            IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage())))
          ],
        ),
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SearchField(),
        )));
  }
}

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        icon: const Icon(
          Icons.chevron_right,
          color: Color(0xff93a1a1),
        ),
        hintText: 'Enter command...',
        border: InputBorder.none,
        hintStyle: TextStyle(fontFamily: "monospace", color: Color(0xff93a1a1)),
      ),
      style: TextStyle(fontFamily: "monospace", color: Color(0xff93a1a1)),
      onSubmitted: (value) => showCommand(context, value),
    );
  }

  void showCommand(BuildContext context, String command) {
    debugPrint(command);
    SnackBar snackBar = SnackBar(content: Text('Command not found!'));

    getCommandDir(command).then((dirs) => {
          if (dirs.isEmpty)
            {
              // command not found
              Scaffold.of(context).showSnackBar(snackBar)
            }
          else if (dirs.length == 1)
            {
              // command found for one platform
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CommandPage(dirs.first + "/" + command)))
            }
          else
            {
              // command found for multiple platforms -> display choice
              choosePlatformDialog(context, dirs).then((dir) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CommandPage(dir + "/" + command))))
            }
        });
  }

  /// searches for [command] in different locations
  ///
  /// if nothing is found it returns an empty list
  Future<List<String>> getCommandDir(String command) async {
    String indexData = "";

    List<String> availableCommands = List();


    // TODO ugly code, make more elegant ;)
    indexData = await getFileData("assets/common-index.txt");
    if (indexData.contains("\n" + command + ".md")) {
      availableCommands.add("common");
    }

    indexData = await getFileData("assets/linux-index.txt");
    if (indexData.contains("\n" + command + ".md")) {
      availableCommands.add("linux");
    }

    indexData = await getFileData("assets/osx-index.txt");
    if (indexData.contains("\n" + command + ".md")) {
      availableCommands.add("osx");
    }

    indexData = await getFileData("assets/windows-index.txt");
    if (indexData.contains("\n" + command + ".md")) {
      availableCommands.add("windows");
    }

    indexData = await getFileData("assets/sunos-index.txt");
    if (indexData.contains("\n" + command + ".md")) {
      availableCommands.add("sunos");
    }

    return availableCommands;
  }

  // TODO remove duplicate code...
  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  Future<String> choosePlatformDialog(context, List<String> dirs) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Platform'),
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dirs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(dirs[index]),
                    onTap: () {
                      Navigator.pop(context, dirs[index]);
                    },
                  );
                },
              ),
            ),
          );
        });
  }
}
