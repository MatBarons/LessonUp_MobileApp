import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:progetto_ium/BottomNavigationBarPages/Login.dart';
import 'package:provider/provider.dart';

import 'package:progetto_ium/BottomNavigationBarPages/Homepage.dart';
import 'package:progetto_ium/BottomNavigationBarPages/Cart.dart';
import 'package:progetto_ium/BottomNavigationBarPages/PastOrders.dart';
import 'package:progetto_ium/BottomNavigationBarPages/Settings.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/TextStylesAndColors.dart';




void main(){
  return runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    )
  );  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Progetto',
        initialRoute: 'Root',
        themeMode: ThemeMode.system,
        theme: ThemeData(useMaterial3: true, colorScheme: theme.getTheme()),
        home: FutureBuilder(
          future:SessionManager().get("login_state"),
          builder: (context, snapshot){
            print(snapshot.data.toString());
            if(snapshot.data.toString()=="true"){
              return Root();
            }
            else{
              return Login();
            }
          },
        ),
      ),
    );
  }
}

/*
FutureBuilder(
  future:SessionManager().get("login_state"),
  builder: (context, snapshot){
    print(snapshot.data.toString());
    if(snapshot.data.toString()=="true"){
      return  Root();
    }
    else{
      return Login();
    }
  },
),
*/

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  Future<bool> isLogged() async{
    String? x = await SessionManager().get("email");
    return  x != null ? true : false;
  }

  int index = 0;
  bool isActive = true;
  
  List<Widget> screens = const [
    Homepage(),
    Cart(),
    Orders(),
    Settings()
  ];

  List<String> labels = const[
    "Progetto IUM",
    "Carrello",
    "Storico Ordini",
    "Impostazioni"
  ];

  @override
  Widget build(BuildContext context) {
    Color navBarBackgroundColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        toolbarHeight: 70,
        title: customText(labels[index], 20,Theme.of(context).colorScheme.onPrimary , FontWeight.w500)
      ),
      //forse si aggiunge il background color
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onSecondaryContainer,
        elevation: 10,
        currentIndex: index,
        selectedFontSize: 12,
        selectedIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary
        ),
        selectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedFontSize: 10,
        unselectedIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSecondaryContainer
        ),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        onTap: (value) => setState(() {
          index = value;
        }),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: "Home",backgroundColor: navBarBackgroundColor),
          BottomNavigationBarItem(icon: const Icon(Icons.shopping_cart), label: "Carrello",backgroundColor: navBarBackgroundColor),
          BottomNavigationBarItem(icon: const Icon(Icons.calendar_month),label: "Storico",backgroundColor: navBarBackgroundColor),
          BottomNavigationBarItem(icon: const Icon(Icons.settings),label: "Impostazioni",backgroundColor: navBarBackgroundColor)
        ],
      ),
    );
  }
}

