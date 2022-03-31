import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../raw_data/dummy_data.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals_to_create_immutables
//ignore_for_file: use_key_in_widget_constructors

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category-meals';

  final List<Meal> availableMeals;


  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayMeals;
  var _loadedInitData = false;

  @override
  void initState() {

    super.initState();
  }


  @override
  void didChangeDependencies() {
    //способ передачи аргументов и перехода на другую страницу ниже - сложный,
    //можно сделать намного легче, но такой способ подходит для больших приложений
    //см 162-164 примерно
    if(!_loadedInitData) {
      final routeArgs =
      ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'] as String;
      final categoryId = routeArgs['id'];
      displayMeals = widget.availableMeals.where((meal) {
        return meal.categories!.contains(categoryId);
      }).toList();_loadedInitData = true;
    }
  }

  void _removeMeal(String mealID) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealID);
    });
  }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals[index].id,
            title: displayMeals[index].title,
            imageUrl: displayMeals[index].imageUrl,
            duration: displayMeals[index].duration,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability,
          );
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}
