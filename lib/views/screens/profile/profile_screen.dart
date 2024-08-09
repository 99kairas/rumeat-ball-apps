import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/profile/personal_data_screen.dart';
import 'package:rumeat_ball_apps/views/screens/profile/profile_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _checkTokenAndLoadProfile());
  }

  Future<void> _checkTokenAndLoadProfile() async {
    final token = await SharedPref.getToken();
    if (token == null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Not Logged In'),
            content: Text('You need to log in to view your profile.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Log In'),
              ),
            ],
          );
        },
      );
    } else {
      Provider.of<ProfileViewModel>(context, listen: false)
          .getUserInfo(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileViewModel>(context);
    final _user = profileProvider.user;
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
      body: profileProvider.isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: primaryColor,
                size: 50,
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(61),
                        image: DecorationImage(
                            image: _user?.profileImage != "" ||
                                    _user?.profileImage != null
                                ? NetworkImage(_user?.profileImage ?? "")
                                    as ImageProvider
                                : const AssetImage(
                                    'assets/images/profile1.png',
                                  )),
                      ),
                    ),
                    Text(
                      _user?.name ?? "",
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
                      _user?.email ?? "",
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
                  style:
                      greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
                ),
                const SizedBox(
                  height: 8,
                ),
                CardProfile(
                  title: "Personal Data",
                  icons: Icons.person_4_outlined,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonalDataScreen(),
                        ));
                  },
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
                  style:
                      greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
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
                  onPressed: () {
                    SharedPref.removeToken();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
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
