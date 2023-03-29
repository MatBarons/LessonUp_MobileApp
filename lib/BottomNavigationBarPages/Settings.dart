import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/CommonWidgets.dart';

import 'package:progetto_ium/Common/StylesAndWidgets/TextStylesAndColors.dart';
import 'package:provider/provider.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});


  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  var session = SessionManager();
  bool activeNotifications = true;
  bool themeSwitch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 20),
          ExpandableNotifier(
            initialExpanded: false,
            child: ScrollOnExpand(
              scrollOnCollapse: true,
              scrollOnExpand: true,
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                  iconColor: Theme.of(context).colorScheme.onBackground
                ),
                header: ListTile(
                  leading: Icon(Icons.person,color: Theme.of(context).colorScheme.primary),
                  title: customText("I tuoi dati", 18, Theme.of(context).colorScheme.onBackground, FontWeight.normal),
                ),
                collapsed: placeholder,
                expanded: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Column(
                    children: [
                      Divider(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),thickness: 1,endIndent: 30),
                      const SizedBox(height: 5),
                      ListTile(
                        leading: Icon(Icons.abc, color: Theme.of(context).colorScheme.primary),
                        title: customText("Visualizza i tuoi dati", 17, Theme.of(context).colorScheme.onBackground, FontWeight.normal),
                        onTap: () {},
                      ),
                      Divider(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),thickness: 1,endIndent: 30),
                      const SizedBox(height: 5),
                      ListTile(
                        leading: Icon(Icons.key, color: Theme.of(context).colorScheme.primary),
                        title: customText("Modifica password", 17, Theme.of(context).colorScheme.onBackground, FontWeight.normal),
                        onTap: () {},
                      )
                      
                    ],
                  ),
                )
              ),
            ),
          ),
          Divider(color: Theme.of(context).colorScheme.onBackground,thickness: 1),
          FutureBuilder(
            future: session.get("notify"),
            builder: (context, snapshot) {
              activeNotifications = snapshot.hasData ? snapshot.data! : false;
              return SwitchListTile(
                title: customText("Notifiche", 18, Theme.of(context).colorScheme.onBackground, FontWeight.normal),
                secondary: activeNotifications ? Icon(Icons.notifications, color: Theme.of(context).colorScheme.primary,) : Icon(Icons.notifications_none, color: Theme.of(context).colorScheme.primary),
                value: activeNotifications, 
                onChanged: (value) {
                  session.set("notify",value);
                  setState(() {
                    activeNotifications = value;
                    
                  });
                },
              );
            },
          ),
          Divider(color: Theme.of(context).colorScheme.onBackground,thickness: 1),
          FutureBuilder(
            future: session.get("theme"),
            builder: (context, snapshot) {
              themeSwitch = snapshot.hasData ? snapshot.data! : true;
              return Consumer<ThemeNotifier>(
                builder: (context, theme, child) {
                  return SwitchListTile(
                    title: customText("Tema", 18, Theme.of(context).colorScheme.onBackground, FontWeight.normal),
                    secondary: themeSwitch ? Icon(Icons.light_mode, color: Theme.of(context).colorScheme.primary)  :  Icon(Icons.dark_mode, color: Theme.of(context).colorScheme.primary),
                    value: themeSwitch, 
                    onChanged: (value) {
                      session.set("theme",value);
                      setState(() {
                        themeSwitch = value;
                        if(themeSwitch == false){
                          theme.setDarkMode();
                        }else{
                          theme.setLightMode();
                        }
                      });
                    },
                  );
                },
              );
            },
          ),
          Divider(color: Theme.of(context).colorScheme.onBackground,thickness: 1),
          ListTile(
            leading: Icon(Icons.help, color: Theme.of(context).colorScheme.primary),
            title: customText("Aiuto", 18, Theme.of(context).colorScheme.onBackground, FontWeight.normal),
            onTap: () {},
          )
          //const Divider(color: Colors.black,thickness: 1),
        ],
      )
    );
  }
}