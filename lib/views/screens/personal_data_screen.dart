import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';
import 'package:rumeat_ball_apps/views/widgets/forms.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final TextEditingController _dateController = TextEditingController();
  String _selectedGender = 'Male';

  void _pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        _dateController.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Data",
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(61),
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/profile1.png",
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 65,
                left: 200,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(61),
                    color: whiteColor,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt),
                    color: primaryColor,
                    iconSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const CustomFormField(
            title: "Full Name",
            hintText: "John Doe",
            errorMessage: "",
            isValid: false,
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () => _pickDate(context),
            child: AbsorbPointer(
              child: CustomFormField(
                title: "Date of Birth",
                hintText: "19/06/1999",
                controller: _dateController,
                errorMessage: "",
                isValid: false,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          CustomDropdown(
            title: "Gender",
            hintText: "Select Gender",
            items: const ["Male", "Female"],
            value: _selectedGender,
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
          ),
          const SizedBox(
            height: 12,
          ),
          const CustomFormField(
            title: "Phone Number",
            hintText: "John Doe",
            errorMessage: "",
            isValid: false,
          ),
          const SizedBox(
            height: 12,
          ),
          const CustomFormField(
            title: "Email",
            hintText: "John Doe",
            errorMessage: "",
            isValid: false,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          CustomFilledButton(
            title: "Save",
            onPressed: () {},
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String title;
  final String hintText;
  final List<String> items;
  final String value;
  final void Function(String?) onChanged;

  const CustomDropdown({
    required this.title,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: regular,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
