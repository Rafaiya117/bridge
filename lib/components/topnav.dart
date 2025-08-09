import 'package:flutter/material.dart';

class CustomTopNavbar extends StatefulWidget implements PreferredSizeWidget {
  final Widget logo;
  final Widget? customItem;
  final VoidCallback? onNotificationPressed;
  final Widget userProfilePic;
  final Color topNavBarColor;
  final Color bottomNavBarColor;
  final TextEditingController searchController;
  final VoidCallback? onPlusPressed;

  final Color floatingButtonColor;
  final ShapeBorder floatingButtonShape;
  final Widget? floatingButtonIcon;
  final String? floatingButtonText;

  const CustomTopNavbar({
    Key? key,
    required this.logo,
    this.customItem,
    this.onNotificationPressed,
    required this.userProfilePic,
    required this.topNavBarColor,
    required this.bottomNavBarColor,
    required this.searchController,
    this.onPlusPressed,
    this.floatingButtonColor = Colors.blueAccent,
    this.floatingButtonShape = const CircleBorder(),
    this.floatingButtonIcon = const Icon(Icons.add, color: Colors.white),
    this.floatingButtonText,
  }) : super(key: key);

  @override
  State<CustomTopNavbar> createState() => _CustomTopNavbarState();

  @override
  Size get preferredSize => const Size.fromHeight(110);
}

class _CustomTopNavbarState extends State<CustomTopNavbar> {
  late FocusNode _searchFocusNode;
  bool _isSearchExpanded = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchExpanded = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      color: widget.topNavBarColor,
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                widget.logo,
                Spacer(),
                if (widget.customItem != null) ...[
                  widget.customItem!,
                  SizedBox(width: 16),
                ],
                IconButton(
                  icon: Icon(Icons.notification_add, color: Colors.black),
                  onPressed: widget.onNotificationPressed,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ClipOval(child: widget.userProfilePic),
                ),
              ],
            ),
          ),
          // Bottom Row – Search + Button
          Container(
            color: widget.bottomNavBarColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Search
                _isSearchExpanded
                    ? Expanded(
                  child: TextField(
                    controller: widget.searchController,
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          widget.searchController.clear();
                          _searchFocusNode.unfocus();
                        },
                      ),
                    ),
                  ),
                )
                    : Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.search, color: Colors.grey.shade700),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(_searchFocusNode);
                    },
                  ),
                ),

                // Spacer to push button to right (only when search is not expanded)
                if (!_isSearchExpanded) Spacer(),

                // Create Post Button
                MaterialButton(
                  onPressed: widget.onPlusPressed,
                  color: widget.floatingButtonColor,
                  shape: widget.floatingButtonShape,
                  padding: widget.floatingButtonText != null
                      ? const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
                      : const EdgeInsets.all(12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.floatingButtonIcon != null) widget.floatingButtonIcon!,
                      if (widget.floatingButtonText != null) ...[
                        if (widget.floatingButtonIcon != null) const SizedBox(width: 6),
                        Text(
                          widget.floatingButtonText!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CustomTopNavbarWrapper extends StatelessWidget implements PreferredSizeWidget {
  final CustomTopNavbar customTopNavbar;

  const CustomTopNavbarWrapper({Key? key, required this.customTopNavbar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return customTopNavbar;
  }

  @override
  Size get preferredSize {
    final statusBarHeight = MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    return Size.fromHeight(customTopNavbar.preferredSize.height + statusBarHeight);
  }
}
