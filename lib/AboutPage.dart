import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff002b36),
        appBar: AppBar(
          backgroundColor: Color(0xff073642),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text("About"),
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset("assets/launcher/app-icon.png", height: 200,),
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snap) {
                if (!snap.hasData) return Container();
                PackageInfo info = snap.data;
                return Column(
                  children: <Widget>[
                    Text('${info.appName}', style: getStyle()),
                    Text('${info.packageName}', style: getStyle()),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Version ${info.version}', style: getStyle()),
                    Text('Build ${info.buildNumber}', style: getStyle()),
                  ],
                );
              },
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              child: Text('GitHub: github.com/philcoffeejunkie/tldrflutter'),
              onPressed: () {
                launch('https://github.com/');
              },
            ),
            RaisedButton(
              child: Text('Twitter: @ph_coffeejunkie'),
              onPressed: () {
                launch('https://twitter.com/ph_coffeejunkie');
              },
            ),
          ],
        )));
  }

  TextStyle getStyle() {
    return TextStyle(fontFamily: "monospace", color: Color(0xff93a1a1));
  }
}
