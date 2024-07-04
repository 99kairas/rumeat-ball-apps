import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
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
                    left: 65,
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
              Text(
                "Rizki Andika Setiadi",
                textAlign: TextAlign.justify,
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                textAlign: TextAlign.justify,
                "rizki1@gmail.com",
                style: greyTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: regular,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          Text(
            "My Profile",
            style: greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
          ),
          const SizedBox(
            height: 8,
          ),
          CardProfile(
            title: "Personal Data",
            icons: Icons.person_4_outlined,
            onPressed: () {},
          ),
          CardProfile(
            title: "Settings",
            icons: Icons.settings_outlined,
            onPressed: () {},
          ),
          const SizedBox(
            height: 28,
          ),
          Text(
            "Supports",
            style: greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
          ),
          CardProfile(
            title: "Help Center",
            icons: Icons.info_outline,
            onPressed: () {},
          ),
          CardProfile(
            title: "Request Account Deletion",
            icons: Icons.delete_outline,
            onPressed: () {},
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          CustomFilledButton(
            color: redColor,
            title: "Sign Out",
            style: redTextStyle.copyWith(
              fontSize: 16,
              fontWeight: regular,
            ),
            onPressed: () {},
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class CardProfile extends StatelessWidget {
  final IconData? icons;
  final String title;
  final Function() onPressed;
  const CardProfile({
    super.key,
    this.icons,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(
              icons,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
