import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/views/screens/profile/personal_data_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';
import 'package:rumeat_ball_apps/views/widgets/forms.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PersonalDataViewModel>(context, listen: false).getUserInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    final personalProvider = Provider.of<PersonalDataViewModel>(context);
    final _data = personalProvider.user;
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
                  image: DecorationImage(
                    image: _data?.profileImage != "" && _data?.profileImage != null
                        ? NetworkImage(_data!.profileImage!)
                        : const AssetImage('assets/images/profile1.png') as ImageProvider,
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
                    onPressed: () {
                      personalProvider.updateFotoProfile(context);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.camera_alt),
                    color: primaryColor,
                    iconSize: 20,
                  ),
                ),
              ),
            ],
          ),
          CustomFormField(
            title: "Full Name",
            hintText: "${_data?.name}",
            errorMessage: "",
            enabled: false,
            isValid: false,
          ),
          CustomFormField(
            title: "Email",
            hintText: "${_data?.email}",
            errorMessage: "",
            enabled: false,
            isValid: false,
          ),
          CustomFormField(
            title: "Phone Number",
            hintText: "${_data?.phone}",
            errorMessage: "",
            controller: personalProvider.phoneController,
            isValid: false,
          ),
          CustomFormField(
            title: "Address",
            hintText: "${_data?.address}",
            controller: personalProvider.addressController,
            errorMessage: "",
            isValid: false,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          CustomFilledButton(
            title: "Save",
            onPressed: () {
              personalProvider.updateProfile(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
