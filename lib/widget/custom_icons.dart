import 'package:flutter/material.dart';
import '../utils/app_styles.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double size;
  final bool isOutlined;

  const CustomIcon({
    Key? key,
    required this.icon,
    this.color,
    this.size = 24,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 8,
      height: size + 8,
      decoration: BoxDecoration(
        color: isOutlined ? Colors.transparent : (color ?? AppColors.ultraLightGrey),
        borderRadius: BorderRadius.circular(8),
        border: isOutlined
            ? Border.all(color: color ?? AppColors.lightGrey, width: 1.5)
            : null,
      ),
      child: Center(
        child: Icon(
          icon,
          size: size * 0.6,
          color: color ?? AppColors.grey,
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const ProfileAvatar({
    Key? key,
    this.imageUrl,
    this.initials,
    this.size = 40,
    this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? AppColors.ultraLightGrey,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          image: imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: imageUrl == null
            ? Center(
                child: initials != null
                    ? Text(
                        initials!,
                        style: TextStyle(
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: size * 0.4,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        color: AppColors.grey,
                        size: size * 0.6,
                      ),
              )
            : null,
      ),
    );
  }
}

class AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double size;

  const AnimatedIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = 24,
  }) : super(key: key);

  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Icon(
                widget.icon,
                color: widget.color ?? AppColors.grey,
                size: widget.size,
              ),
            ),
          );
        },
      ),
    );
  }
}
