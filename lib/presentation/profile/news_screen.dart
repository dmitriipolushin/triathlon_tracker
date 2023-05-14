import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:triathlon_tracker/constants.dart';
import 'package:triathlon_tracker/presentation/landing_screen.dart';
import 'package:triathlon_tracker/presentation/profile/avatar_widget.dart';
import 'package:triathlon_tracker/presentation/profile/news_details_screen.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.only(
            top: i == 0 ? 50 : 12,
            bottom: i == 9 ? 24 : 12,
          ),
          child: NewsWidget(
            news: News(
              title: 'Clippers prevent Pelicans from clinching play-in spot',
              publishDate: DateTime.now().toString(),
            ),
          ),
        );
      },
    );
  }
}

class News {
  final String title;
  final String publishDate;
  final String? image;
  const News({
    required this.title,
    required this.publishDate,
    this.image,
  });
}

class NewsWidget extends StatelessWidget {
  final News news;
  const NewsWidget({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showNewsDetailedScreenDialog(
          globalContext!,
          news: news,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: AppColors.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: RectangularAvatarWidget(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.35,
                  imageUrl: news.image,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0).copyWith(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        news.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      _formatDate(news.publishDate),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String startAt) {
    final DateTime dateTime = DateTime.parse(startAt);
    return '${DateFormat().add_MMMd().add_jm().format(dateTime)} EST';
  }
}

showNewsDetailedScreenDialog(
  BuildContext context, {
  required News news,
}) {
  return showMaterialModalBottomSheet(
    context: context,
    bounce: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: AppColors.primaryColor,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: 41,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                ),
                Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      if (Platform.isAndroid) {
                        notification.disallowIndicator();
                      }
                      return true;
                    },
                    child: NewsDetailsScreen(
                      controller: ModalScrollController.of(context)!,
                      news: news,
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 16,
              right: 16,
              child: CloseButton(),
            )
          ],
        ),
      );
    },
  );
}

class CloseButton extends StatelessWidget {
  const CloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Center(
          child: Icon(
            Icons.close_rounded,
            color: Color(0xFF61617A),
            size: 16,
          ),
        ),
      ),
    );
  }
}
