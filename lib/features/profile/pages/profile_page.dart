import 'package:bd_erp/components/auth_check.dart';
import 'package:bd_erp/features/profile/repository/profile_repository.dart';
import 'package:bd_erp/models/user_model.dart';
import 'package:bd_erp/static/network/urls.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = widget.userModel;
    return Scaffold(
      backgroundColor: AppThemes.darkerGrey,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(widget.userModel,context),
          SliverList(
            delegate: SliverChildListDelegate([
              const Center(
                  child: Text("Student Details",
                      style: TextStyle(color: AppThemes.white, fontSize: 20))),
              _detailsCard("Name",
                  '${user.firstName} ${user.middleName ?? ""} ${user.lastName}'),
              _detailsCard("Student number", user.admissionNumber),
              _detailsCard("Email", user.email),
              _detailsCard("Student phone", user.smsMobileNumber),

              const Center(
                  child: Text("Parent Details",
                      style: TextStyle(color: AppThemes.white, fontSize: 20))),
              _detailsCard("Father's Name", user.fatherName),
              _detailsCard("Mother's Name", user.motherName),
              _detailsCard("Contact no.", user.parentMobileNumber),
              const Center(
                  child: Text("Resident Details",
                      style: TextStyle(color: AppThemes.white, fontSize: 20))),
              _detailsCard("Resident", user.address),

              // _detailsCard("Resident", user.address),
            ]),
          ),
        ],
      ),
    );
  }
}

Widget _detailsCard(String label, String data) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Container(
      // height: 150,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 3), // Reduced margin
      decoration: BoxDecoration(
        color: AppThemes.backgroundLightGrey,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(label,
                  style: const TextStyle(color: AppThemes.white, fontSize: 10)),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              data,
              style: const TextStyle(
                  color: AppThemes.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildAppBar(UserModel userData,context) {
  return SliverAppBar(
    foregroundColor: AppThemes.white,
    elevation: 3,
    expandedHeight: 190.0,
    centerTitle: false,
    pinned: true,
    actions: [
      PopupMenuButton<String>(
        icon: const Icon(Icons.menu),
        color: AppThemes.darkerGrey,
        iconColor: AppThemes.white,
        onSelected: (String value)  {
          // Handle menu item selection
          switch (value) {
            case 'logout':
              () async {
                // Use a logging framework instead of print
                debugPrint('Selected: $value'); 
                await ProfileRepository().signOut();
                Navigator.pushAndRemoveUntil(context, PageTransition(child: const AuthCheck(), type: PageTransitionType.fade), (route) => false);
              }();
              break;
            case 'eIdentity':
              // _openEIdentity(context);
              break;
            case 'contactUs':
              // _contactUs(context);
              break;
          }
        },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            value: 'eIdentity',
            child: Text(
              "E-Identity",
              style: TextStyle(color: AppThemes.white, fontSize: 20),
            ),
          ),
          const PopupMenuItem(
            value: 'contactUs',
            child: Text(
              "Contact Us",
              style: TextStyle(color: AppThemes.white, fontSize: 20),
            ),
          ),
          const PopupMenuItem(
            value: 'logout',
            child: Text(
              "Logout",
              style: TextStyle(color: AppThemes.white, fontSize: 20),
            ),
          ),
        ],
      ),
    ],
    backgroundColor: AppThemes.darkerGrey,
    flexibleSpace: FlexibleSpaceBar(
      expandedTitleScale: 1.8,
      centerTitle: true,
      titlePadding: const EdgeInsets.only(left: 10, right: 10, top: 50),
      title: Hero(
        tag: "profile",
        child: Container(
          margin: EdgeInsets.only(bottom: 4),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: AppThemes.white,
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    Urls.imageApi + userData.profilePictureId.toString() ?? ""),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppThemes.highlightYellow, width: 2),
          ),
        ),
      ),
    ),
  );
}
