import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triathlon_tracker/core/s.dart';

class OptionsScreen extends StatefulWidget {
  final ValueChanged<List<int>?> onChanged;
  const OptionsScreen({
    super.key,
    required this.onChanged,
  });

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  late final List<String> _options = [
    '${S.of(context).sprint} (0.75/20/5 ${S.of(context).km})',
    '${S.of(context).olympic} (1.5/40/10 ${S.of(context).km})',
    '${S.of(context).o2} (3/80/20 ${S.of(context).km})',
    '${S.of(context).half_ironman} (1.9/90/21.0975 ${S.of(context).km})',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 44),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            S.of(context).distance_question,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF40445C),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ).copyWith(
            top: 24,
          ),
          child: Text(
            S.of(context).distance_explanation,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9EA1B2),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Align(
              alignment: Alignment.center,
              child: Options(
                options: _options,
                initialOption: _options.first,
                onChanged: (val) {
                  if (val == _options[1]) {
                    widget.onChanged([60, 900, 350]);
                  } else if (val == _options[2]) {
                    widget.onChanged([120, 2000, 750]);
                  } else if (val == _options[3]) {
                    widget.onChanged([100, 2200, 800]);
                  } else {
                    widget.onChanged([40, 500, 200]);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Options extends StatefulWidget {
  final List<String> options;
  final bool useCheckBox;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<List<String>>? chosenOptions;
  final int? oddItem;
  final List<String>? buttonImages;
  final String? initialOption;
  final List<String>? selectedOptions;
  const Options({
    Key? key,
    required this.options,
    this.onChanged,
    this.useCheckBox = false,
    this.chosenOptions,
    this.oddItem,
    this.buttonImages,
    this.initialOption,
    this.selectedOptions,
  }) : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> with TickerProviderStateMixin {
  int? _currentIndex;
  List<String> _chosenOptions = [];

  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.options.length; i++) {
      final AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      );

      final Animation<double> animation = CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      );
      _controllers.add(controller);
      _animations.add(animation);
    }
    if (widget.initialOption != null) {
      _currentIndex = widget.options.indexOf(widget.initialOption!);
    }
    if (widget.selectedOptions != null) {
      _chosenOptions = widget.selectedOptions!;
      for (var item in _chosenOptions) {
        _controllers[widget.options.indexOf(item)].forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.options.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 0 : 12,
            bottom: index == widget.options.length - 1 ? 0 : 12,
            left: 15,
            right: 15,
          ),
          child: _buildOptionItem(
            context,
            title: widget.options[index],
            index: index,
          ),
        );
      },
    );
  }

  Widget _buildOptionItem(
    BuildContext context, {
    required final String title,
    required final int index,
  }) {
    final bool isChosen = widget.useCheckBox
        ? _chosenOptions.contains(title)
        : _currentIndex == index;

    Widget buildRadioItem({bool isChosen = false}) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: isChosen ? const Color(0xFF4A4999) : const Color(0xFFD6D7E4),
          ),
        ),
        child: Center(
          child: AnimatedContainer(
            width: isChosen ? 6 : 0,
            height: isChosen ? 6 : 0,
            duration: const Duration(milliseconds: 200),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF4A4999),
            ),
          ),
        ),
      );
    }

    Widget buildCheckBox({bool isChosen = false}) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(
            width: 1,
            color: isChosen ? const Color(0xFF4A4999) : const Color(0xFFD6D7E4),
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _animations[index],
            child: const Icon(
              CupertinoIcons.checkmark_alt,
              color: Color(0xFF4A4999),
              size: 12,
            ),
          ),
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 76,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: isChosen ? const Color(0xFF4A4999) : const Color(0xFFD6D7E4),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(4, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (widget.useCheckBox) {
              if (isChosen) {
                _chosenOptions.remove(title);
                _controllers[index].reverse();
              } else {
                if (index == widget.oddItem) {
                  for (var controller in _controllers) {
                    controller.reverse();
                  }
                  _chosenOptions.clear();
                } else if (widget.oddItem != null &&
                    _chosenOptions.contains(widget.options[widget.oddItem!])) {
                  _chosenOptions.remove(widget.options[widget.oddItem!]);
                }
                _chosenOptions.add(title);
                _controllers[index].forward();
              }
              setState(() {});
              widget.chosenOptions!(_chosenOptions);
            } else {
              setState(() {
                _currentIndex = index;
              });
              widget.onChanged!(widget.options[index]);
            }
          },
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Center(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16).copyWith(
                    bottom: 36,
                  ),
                  child: Row(
                    children: [
                      if (widget.useCheckBox && widget.oddItem != index) ...[
                        buildCheckBox(isChosen: isChosen)
                      ] else ...[
                        buildRadioItem(isChosen: isChosen)
                      ],
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF40445C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.buttonImages != null) ...[
                  if (widget.buttonImages!.length == 1) ...[
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(15),
                        ),
                        child: Image.asset(
                          widget.buttonImages!.first,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ] else ...[
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(15),
                        ),
                        child: Image.asset(
                          widget.buttonImages![index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ]
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
