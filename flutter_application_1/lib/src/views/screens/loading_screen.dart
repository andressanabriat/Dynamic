import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/views/screens/user_filter_screen.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToFiltro();
  }

  _navigateToFiltro() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => UserFilterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            width * 0.08,
            height * 0.03,
            width * 0.08,
            height * 0.03,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.4),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/Logos/Logo_Dynamic.png',
                  width: width * 0.3,
                  height: width * 0.3,
                ),
              ),
              SizedBox(height: height * 0.3),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Dynamic',
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
