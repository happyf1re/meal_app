import 'package:flutter/material.dart';
import 'package:meal_app/screens/filters_screen.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals_to_create_immutables
//ignore_for_file: use_key_in_widget_constructors

class MainDrawer extends StatelessWidget {

  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
              'Meals',
              Icons.restaurant,
              () {
                //pushReplacement пушит страницу наверх и удаляет старую
                //таким образом избавляемся от постоянно растущего стека страниц
                Navigator.of(context).pushReplacementNamed('/');
              }),
          buildListTile('Filters',
              Icons.settings,
              () {
                Navigator
                    .of(context).pushReplacementNamed(FiltersScreen.routeName);
              }),
        ],
      ),
    );
  }
}
