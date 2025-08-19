import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routine/app/auth/presentation/cubit/auth_cubit.dart';
import 'package:routine/app/root/pages/home_page.dart';
import 'package:routine/app/root/pages/profile_screen.dart';
import 'package:routine/app/note/presentation/cubit/note_cubit.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/src/theme/app_colors.dart';
import 'package:routine/app/note/presentation/screens/create_note_screen.dart';

class AppRootScreen extends StatefulWidget {
  const AppRootScreen({super.key});

  @override
  State<AppRootScreen> createState() => _AppRootScreenState();
}

class _AppRootScreenState extends State<AppRootScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var icons = [Icons.home, Icons.add, Icons.settings];
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [HomePage(), SizedBox(), ProfileScreen()],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 50, left: 50, right: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(icons.length, (index) {
            if (index == 1) {
              //replace with fab
              return SizedBox(
                width: 46,
                height: 46,
                child: FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    context.push(CreateNoteScreen());
                  },
                  child: Icon(icons[index]),
                ),
              );
            }
            return InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: NavIcon(
                icon: icons[index],
                selected: _currentIndex == index,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class NavIcon extends StatelessWidget {
  const NavIcon({super.key, required this.icon, this.selected = false});

  final bool selected;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: selected ? context.colorScheme.onSurface : AppColors.grey7D,
      size: 25,
    );
  }
}
