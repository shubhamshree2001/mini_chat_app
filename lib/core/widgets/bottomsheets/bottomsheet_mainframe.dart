import 'package:flutter/material.dart';


class BottomSheetMainFrame extends StatelessWidget {
  final Widget Function(ScrollController controller)? content;
  final VoidCallback? onCtaClick;
  final String? ctaLabel;
  final String? label;
  final Widget? labelWidget;
  final double? initialChildSize;
  final double? minChildSize;
  final VoidCallback? onCloseClick;

  const BottomSheetMainFrame({
    super.key,
    this.content,
    this.onCtaClick,
    this.ctaLabel,
    this.label,
    this.labelWidget,
    this.initialChildSize,
    this.minChildSize,
    this.onCloseClick,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: initialChildSize ?? 0.8,
      minChildSize: minChildSize ?? 0.75,
      maxChildSize: 0.9,
      snap: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color:
                 Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 80,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0XFFECECEC),
                  ),
                ),
              ),
              SizedBox(width: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  labelWidget != null
                      ? labelWidget!
                      : Text(
                    label.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  InkWell(
                    onTap: onCloseClick != null
                        ? onCloseClick!
                        : () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  child: content?.call(scrollController) ?? const SizedBox(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
