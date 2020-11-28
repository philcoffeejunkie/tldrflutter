import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CommandPage extends StatelessWidget {
  String command;

  CommandPage(this.command);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff002b36),
        appBar: AppBar(
          backgroundColor: Color(0xff073642),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)
          ),
          title: Text(this.command),
        ),
        body: FutureBuilder(
            future: getFileData("assets/" + command + ".md"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Markdown(data: snapshot.data, styleSheet: MarkdownStyleSheet(p: TextStyle(color: Color(0xff93a1a1)), code: TextStyle(color: Colors.red)),);
              } else {
                return Markdown(data: ""); // TODO show progress indicator instead
              }
            }
            ));
  }

  Future<String> getFileData(String path) async {
    debugPrint("reading " + path);
    return await rootBundle.loadString(path);
  }
}
