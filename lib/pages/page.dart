import 'package:flutter/material.dart';
import 'package:myinfo/models/faculty.dart';
import 'package:myinfo/models/grade.dart';
import 'package:myinfo/models/major.dart';
import 'package:myinfo/models/drink.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key, this.title }) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _studentidcontroller = TextEditingController();
  
  String? gradeValue;
  String? majorValue;

  late List<Grade> grades;
  late List<Major> majors;
  late List<Faculty> dropdownItems = Faculty.getfaculty();
  late List<DropdownMenuItem<Faculty>> dropdownMenuItems;
  late Faculty _selectedFaculty;
  late List<Drink> drinks;
  List selectDrink = [];

  @override
  void initState() {
    grades = Grade.getgrade();
    majors = Major.getmajor();
    dropdownMenuItems = createDropdownMenu(dropdownItems);
    _selectedFaculty = dropdownMenuItems[0].value!;
    drinks = Drink.getDrink();
  }

   List<DropdownMenuItem<Faculty>> createDropdownMenu(
     List<Faculty> dropdownItems) {
     List<DropdownMenuItem<Faculty>> facultys = [];

    for (var faculty in dropdownItems) {
      facultys.add(
        DropdownMenuItem(
          child: Text(faculty.name!),
          value: faculty,
        ),
      );
    }
    return facultys;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  textt('ข้อมูลส่วนตัว'),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  name(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  studentid(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  textt('ชั้นปีที่กำลังศึกษา'),
                  radio(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  textt('หลักสูตรที่กำลังศึกษา'),
                  major(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  textt('คณะที่กำลังศึกษา'),
                  dropdown(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  textt('เครื่องดื่มที่ชอบ'),
                  drink(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  submit(),
                ],
              ),
            ), 
          ),
        ],
      ),
      
    );
  }

  Widget submit() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('ยืนยันการบันทึกข้อมูล'),
              content: const Text('ตรวจสอบข้อมูลให้ถูกต้องก่อนกดยืนยัน'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('ยกเลิก'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('ตกลง'),
                ),
              ],
            ),
          );
          if (_formKey.currentState!.validate()) {
            print(_namecontroller.text);
            print(_studentidcontroller.text);
          }
          return;
        },
        child: const Text(
          'ยืนยัน',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Column drink() {
    return Column(
                  children: createDrinkCheckbox());
  }

  DropdownButton<Faculty> dropdown() {
    return DropdownButton(
      value: _selectedFaculty,
      items: dropdownMenuItems,
      onChanged: (Faculty? value) {
        setState(() {
          _selectedFaculty = value as Faculty;
        });
      },
    );
  }

  Column major() {
    return Column(
      children: createMajorradio());
  }

  Column radio() {
    return Column(
      children: createGraderadio(),
    );
  }

  TextFormField studentid() {
    return TextFormField(
      controller: _studentidcontroller,
      validator: (value){
        if (value!.isEmpty){
          return 'Enter Your Student ID';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      maxLength: 9,
      decoration: const InputDecoration(
        labelText: 'Student ID', 
        prefixIcon: Icon(Icons.article),
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 2,
          color: Colors.pink,
        )
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 2,
          color: Colors.grey,
        )
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 2,
          color: Colors.red,
        )
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 2,
          color: Colors.red,
        )
      )
              ),
            );
  }

  TextFormField name() {
    return TextFormField(
      controller: _namecontroller,
      validator: (value){
        if (value!.isEmpty){
          return 'Enter Your Name - Surname';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Name - Surname', 
        prefixIcon: Icon(Icons.person),
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 2,
          color: Colors.pink,
        )
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 2,
          color: Colors.grey,
        )
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 2,
          color: Colors.red,
        )
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 2,
          color: Colors.red,
        )
      )
              ),
            );
  }

  Text textt(tex) {
    return Text(tex, 
        style:const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ) ,);
  }
  List<Widget> createGraderadio() {
    List<Widget> listradiograde = [];

    for (var grade in grades) {
      listradiograde.add(
        RadioListTile<dynamic>(
          title: Text('ชั้นปีที่ ' + grade.number!),
          value: grade.gradevalue, 
          groupValue: gradeValue, 
          onChanged: (value) {
            setState(() {
              gradeValue = value;
              print(value); 
            }
            );
          },
      ),
      
      );
  }
  return listradiograde;
  }

  List<Widget> createMajorradio() {
     List<Widget> listradiomajor = [];

    for (var major in majors) {
      listradiomajor.add(
        RadioListTile<dynamic>(
          title: Text(major.thName!),
          subtitle: Text(major.enName!),
          value: major.majorvalue, 
          groupValue: majorValue, 
          onChanged: (value) {
            setState(() {
              majorValue = value;
              print(value); 
            }
            );
          },
      ),
      
      );
  }
  return listradiomajor;

  }

  List <Widget> createDrinkCheckbox() {
    List <Widget> listCheckboxDrink = [];
      for (var drink in drinks){
      listCheckboxDrink.add(
          CheckboxListTile (
            title: Text(drink.name!),
            subtitle: Text(drink.price! + ' ฿'),
            value: drink.checked, 
            onChanged: (value) {
              setState(() {
                drink.checked = value!;
              }
              );
              if (value!){
                selectDrink.add(drink.name!);
              }
              else {
                selectDrink.remove(drink.name!);
              }
              print(selectDrink);
            },
          ),         
      );
    }
    return listCheckboxDrink ;
  }
}
