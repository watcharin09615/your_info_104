class Faculty{
  int? value;
  String? name;
  Faculty(this.value, this.name);

  static List<Faculty> getfaculty() {
    return [
      Faculty(1, 'คณะวิทยาศาสตร์'),
      Faculty(2, 'คณะวิทยาการสุขภาพและการกีฬา'),
      Faculty(3, 'คณะศึกษาศาสตร์'),
      Faculty(4, 'คณะอุตสาหกรรมเกษตรและชีวภาพ'),
      Faculty(5, 'คณะพยาบาลศาสตร์'),
      Faculty(6, 'คณะวิศวกรรมศาสตร์'),
      Faculty(7, 'คณะเทคโนโลยีและการพัฒนาชุมชน'),
      Faculty(8, 'คณะนิติศาสตร์'),
    ];
  }

}