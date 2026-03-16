import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const MenuCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {

  double scale = 1;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      scale = 1;
    });
  }

  void _onTapCancel() {
    setState(() {
      scale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: scale,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                widget.icon,
                size: 50,
                color: Colors.white,
              ),

              const SizedBox(height: 12),

              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}