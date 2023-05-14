import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:triathlon_tracker/presentation/profile/news_screen.dart';

class NewsDetailsScreen extends StatelessWidget {
  final ScrollController controller;
  final News news;
  const NewsDetailsScreen({
    super.key,
    required this.controller,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _formatDate(news.publishDate),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ).copyWith(bottom: 40),
            child: HtmlWidget(
              '',
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFFEBEBEE),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String startAt) {
    final DateTime dateTime = DateTime.parse(startAt);
    return '${DateFormat().add_MMMd().add_jm().format(dateTime)} EST';
  }
}
