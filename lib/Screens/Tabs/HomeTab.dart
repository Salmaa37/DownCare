import 'package:downcare/Screens/Section.dart';
import 'package:flutter/cupertino.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Section(text: "Mom Section",img: "momsection"),
          Section(text: "Child Section",img: "childsection",)
        ],
      ),
    );
  }
}
