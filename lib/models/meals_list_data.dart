class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Bửa sáng',
      kacl: 525,
      meals: <String>['Bánh mì,', 'Bơ đậu,', 'Táo'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Bữa trưa',
      kacl: 602,
      meals: <String>['Cá hồi,', 'Salad ,', 'Bơ'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Bữa phụ',
      kacl: 0,
      meals: <String>['Đề xuất:', 'Một vài món ăn'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Bữa tối',
      kacl: 0,
      meals: <String>['Đề xuất:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
