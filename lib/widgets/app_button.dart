import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool loading;
  final bool disableTouchWhenLoading;
  final ShapeBorder shape;
  final Widget image;
  final Color backgroundColor;


  AppButton({
    Key key,
    this.onPressed,
    this.text,
    this.loading = false,
    this.disableTouchWhenLoading = false,
    this.shape,
    this.image,
    this.backgroundColor
  }) : super(key: key);

  Widget _buildLoading() {
    if (!loading) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: 14,
      height: 14,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: backgroundColor,
      shape: shape,
      onPressed: disableTouchWhenLoading && loading ? null : onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 5, top: 8, bottom: 8),
                      child: image
                    ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          _buildLoading()
        ],
      ),
    );
  }
}
