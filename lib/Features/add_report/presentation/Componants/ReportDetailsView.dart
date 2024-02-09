import 'package:flutter/material.dart';

class ReportDetails extends StatefulWidget {
  static String? secondDropdownValue;
  static TextEditingController noteTexetController = TextEditingController();
  final int checker;
  //void Function(String?) onDropdownValueChanged; // Function to pass the selected value to the parent class

  ReportDetails({Key? key, required this.checker}) : super(key: key);

  @override
  State<ReportDetails> createState() => _SecondPageState();
}

class _SecondPageState extends State<ReportDetails> {
  @override
  Widget build(BuildContext context) {
    Widget contentWidget;
    String? dropdownvalue;

    List<String> secondItems = [];

    // Determine the items for the second dropdown list based on the value of the first dropdown
    if (widget.checker == 0) {
      // If the first dropdown value corresponds to the first item in the list
      secondItems = [
        'حفرة في الطريق',
        'تحسين المشهد الحضاري',
        'نظافة عامة',
        'أرصفة وحواجز طرق متهالكة'
      ];
    } else if (widget.checker == 1) {
      // If the first dropdown value corresponds to the second item in the list
      secondItems = [
        'انقطاع التيار الكهربائي',
        'وصلات كهربائية غير شرعية',
        'أعمدة انارة عامة'
      ];
    } else if (widget.checker == 3) {
      // If the first dropdown value corresponds to the second item in the list
      secondItems = ['عرقلة الطريق العام', 'حواجز طريق', 'سيارات تالفة ومهملة'];
    } else if (widget.checker == 2) {
      // If the first dropdown value corresponds to the second item in the list
      // secondItems = ['10', '11', '12'];
    } else if (widget.checker == 5) {
      // If the first dropdown value corresponds to the second item in the list
      secondItems = [];
    }

    return Column(
      children: [
        SizedBox(
          height: 40,
          child: DropdownButton(
              borderRadius: BorderRadius.circular(8),
              value: secondItems.isNotEmpty ? secondItems[0] : null,
              items: secondItems.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  ReportDetails.secondDropdownValue = newValue;
                });
              }),
        ),
        // (widget.checker == 5)
        //     ? SizedBox()
        //     :
        TextField(
          controller: ReportDetails.noteTexetController,
          decoration: InputDecoration(
              hintText: "أضف بعض التفاصيل لو أمكن",
              border: OutlineInputBorder()),
        )
      ],
    );
  }
}
