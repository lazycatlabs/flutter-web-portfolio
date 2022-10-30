import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazycatlabs/data/data.dart';
import 'package:lazycatlabs/di/di.dart';
import 'package:lazycatlabs/presentation/presentation.dart';

extension ContextExtensions on BuildContext {
  Future bottomSheet({
    required String title,
    required List<Widget> children,
  }) =>
      showModalBottomSheet(
        context: this,
        enableDrag: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.space30),
            topRight: Radius.circular(Dimens.space30),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: Dimens.space16,
        builder: (context) {
          return AnimatedPadding(
            padding: EdgeInsets.only(
              left: Dimens.space16,
              right: Dimens.space16,
              top: Dimens.space24,
              bottom: Dimens.space24 + MediaQuery.of(context).viewInsets.bottom,
            ),
            duration: const Duration(milliseconds: 300),
            child: Wrap(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: Dimens.bottomBar,
                    height: Dimens.space8,
                    margin: EdgeInsets.only(bottom: Dimens.space24),
                    decoration: const BoxDecoration(
                      color: Palette.disable,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: Theme.of(this).textTheme.headline6,
                    textAlign: TextAlign.left,
                  ),
                ),
                SpacerV(value: Dimens.space24),
                for (var child in children) child,
              ],
            ),
          );
        },
      );

  double widthInPercent(double percent) {
    final toDouble = percent / 100;

    return MediaQuery.of(this).size.width * toDouble;
  }

  double heightInPercent(double percent) {
    final toDouble = percent / 100;

    return MediaQuery.of(this).size.height * toDouble;
  }

  // Handle dialog
  Future<void> dialog({required List<Widget> children, String? title}) =>
      showDialog(
        context: this,
        barrierDismissible: true,
        builder: (c) => WillPopScope(
          onWillPop: () async => false,
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                decoration: BoxDecorations.dialogAlt,
                margin: EdgeInsets.symmetric(horizontal: Dimens.space16),
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Dimens.space16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title ?? "",
                            style: Theme.of(this).textTheme.headline6,
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(c);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: Dimens.space24,
                        left: Dimens.space16,
                        right: Dimens.space16,
                      ),
                      child: Wrap(
                        children: [for (var child in children) child],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  //Start Loading Dialog
  static late BuildContext ctx;

  Future<void> show() => showDialog(
        context: this,
        barrierDismissible: false,
        builder: (c) {
          ctx = c;

          return WillPopScope(
            onWillPop: () async => false,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(this).backgroundColor,
                    borderRadius: BorderRadius.circular(Dimens.cornerRadius),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: Dimens.space30),
                  padding: EdgeInsets.all(Dimens.space24),
                  child: Wrap(children: const [CupertinoActivityIndicator()]),
                ),
              ),
            ),
          );
        },
      );

  void dismiss() {
    try {
      Navigator.pop(ctx);
    } catch (_) {}
  }

  //End Loading Dialog

  void logout() {
    //clear shared Preferences
    sl<PrefManager>().logout();
  }
}
