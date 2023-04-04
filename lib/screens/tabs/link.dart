import 'package:flutter/material.dart';

class NavButton extends StatefulWidget {
  const NavButton({super.key});

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 0, 0, 0),
              // disabledForegroundColor: Colors.red.withOpacity(0.38),
            ),
            onPressed: null,
            child: const Text.rich(
              textAlign: TextAlign.right,
              TextSpan(
                children: [
                  WidgetSpan(
                      child: Icon(Icons.skip_previous, color: Colors.black)),
                  TextSpan(
                      text: 'Previous', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              // disabledForegroundColor: Colors.red.withOpacity(0.38),
            ),
            onPressed: null,
            child: const Text.rich(
              textAlign: TextAlign.left,
              TextSpan(
                children: [
                  TextSpan(text: 'Next', style: TextStyle(color: Colors.black)),
                  WidgetSpan(child: Icon(Icons.skip_next, color: Colors.black)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class LogoImg extends StatefulWidget {
  const LogoImg({super.key});

  @override
  State<LogoImg> createState() => _LogoImgState();
}

class _LogoImgState extends State<LogoImg> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/Veryx-logo.png",
        width: 100,
        height: 50,
        fit: BoxFit.contain,
      ),
    );
  }
}
