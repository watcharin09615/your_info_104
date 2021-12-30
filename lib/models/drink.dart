class Drink{
  String? name;
  String? price;
  bool? checked;

  Drink(this.name, this.price, this.checked);

  static List<Drink> getDrink(){
    return [
      Drink('ชานมไข่มุก', '25', false),
      Drink('ชาเขียว', '25', false),
      Drink('ชาเย็น', '25', false),
      Drink('ชาดำเย็น', '20', false),
      Drink('โกโก้', '25', false),
      Drink('ชานมกล้วย', '30', false),
    ];
  }
}