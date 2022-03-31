import 'package:flutter/material.dart';
import 'package:meal_app/screens/category_meals_screen.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals_to_create_immutables
//ignore_for_file: use_key_in_widget_constructors

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);


  //метод, который позволяет перейти на другую страницу
  //страницы расположены в стеке (стопке), так что методы
  //push и pop отражают то, что с ними происходит
  // void selectCategory(BuildContext ctx) {
  //   Navigator.of(ctx).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return CategoryMealsScreen(id, title);
  //       },
  //     ),
  //   );
  // }
  
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
    CategoryMealsScreen.routeName,
      arguments: {'id': id, 'title': title}
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
