import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meal_app/raw_data/dummy_data.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'models/meal.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals_to_create_immutables
//ignore_for_file: use_key_in_widget_constructors

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

   List<Meal> _availableMeals = DUMMY_MEALS;
   List<Meal> _favoriteMeals = [];


   void _setFilters(Map<String, bool> filterData) {
     setState(() {
       _filters = filterData;

       _availableMeals = DUMMY_MEALS.where((meal) {
         if (_filters['gluten'] as bool && !meal.isGlutenFree) {
           return false;
         }
         if (_filters['lactose'] as bool && !meal.isLactoseFree) {
           return false;
         }
         if (_filters['vegan'] as bool && !meal.isVegan) {
           return false;
         }
         if (_filters['vegetarian'] as bool && !meal.isVegetarian) {
           return false;
         }
         return true;
       }).toList();
     });
   }

   void _toggleFavorite(String mealId) {
     final existingIndex =
     _favoriteMeals.indexWhere((meal) => meal.id == mealId);
     if (existingIndex >= 0) {
       setState(() {
         _favoriteMeals.removeAt(existingIndex);
       });
     } else {
       setState(() {
         _favoriteMeals.add(
           DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
         );
       });
     }
   }

   bool _isMealFavorite(String id) {
     return _favoriteMeals.any((meal) => meal.id == id);
   }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoolMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              subtitle1: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        //закомментили строку выше и всё равно работает
        // / - обозначает домашнюю страницу, как и везде
        '/': (ctx) => TabsScreen(_favoriteMeals),
        //используем статическую константу, чтобы ничего не хардкодить
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
    );
  }
}
