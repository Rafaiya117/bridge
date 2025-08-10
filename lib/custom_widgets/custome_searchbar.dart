import 'package:flutter/material.dart';

class SearchAndActionBar extends StatefulWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double borderRadius;
  final VoidCallback onButtonPressed;
  final double buttonFontSize;
  final double buttonHeight;
  final double buttonWidth;

  const SearchAndActionBar({
    Key? key,
    required this.buttonText,
    required this.onButtonPressed,
    this.buttonColor = const Color(0xFF009038),
    this.textColor = Colors.white,
    this.borderRadius = 12.0,
    this.buttonFontSize = 16.0,
    this.buttonHeight = 48.0,
    this.buttonWidth = 150.0,
  }) : super(key: key);

  @override
  State<SearchAndActionBar> createState() => _SearchAndActionBarState();
}

class _SearchAndActionBarState extends State<SearchAndActionBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isSearching ? MediaQuery.of(context).size.width - widget.buttonWidth - 40 : 50.0,
          child: _isSearching
              ? TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _isSearching = false;
                  });
                },
              ),
            ),
          )
              : IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
        ),
        SizedBox(
          height: widget.buttonHeight,
          width: widget.buttonWidth,
          child: ElevatedButton(
            onPressed: widget.onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
            ),
            child: Text(
              widget.buttonText,
              style: TextStyle(
                color: widget.textColor,
                fontSize: widget.buttonFontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
