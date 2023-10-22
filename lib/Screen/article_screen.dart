import 'package:apifetch/Models/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SpinKit.dart';

Future openInApp({required String url, bool inApp = false}) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
    );
  } else {
    throw 'Could not launch $url';
  }
}

class ArticleScreen extends StatelessWidget {
  final Article article;

  ArticleScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(title: Text('Article Detail')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.imageUrl != null && article.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: article.imageUrl!, // Use the imageUrl with a non-null assertion
                    height: screenHeight * 0.45,
                    fit: BoxFit.fill,
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    placeholder: (context, url) =>
                        Container(child: CustomSpinner()),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/blank_img.jpeg',
                      fit: BoxFit.fill,
                      height: 350,
                      width: double.infinity,
                    ),
                  ),
                ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.3, // Set a maximum width
                    child: Text(
                      'Author: ',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 16 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.5, // Set a maximum width
                    child: Text(
                      article.author,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        fontSize: 13 * textScaleFactor,
                        letterSpacing: 1,
                        wordSpacing: 1,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: screenWidth * 0.8, // Set a maximum width
                child: Text(
                  'Title:',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 16 * textScaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: screenWidth * 0.8, // Set a maximum width
                child: Text(
                  article.title,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.normal,
                    fontSize: 13 * textScaleFactor,
                    letterSpacing: 1,
                    wordSpacing: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: screenWidth * 0.8, // Set a maximum width
                child: Text(
                  'Description:',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 16 * textScaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: screenWidth * 0.8, // Set a maximum width
                child: Text(
                  article.description.toString(),
                  style: GoogleFonts.roboto(
                    fontSize: 13 * textScaleFactor,
                    letterSpacing: 0.5,
                    wordSpacing: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: screenWidth * 0.8, // Set a maximum width
                child: Text(
                  article.publishedAt,
                  style: TextStyle(
                    fontSize: 12 * textScaleFactor,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  final url = article.url;
                  openInApp(url: url, inApp: true);
                },
                child: Container(
                  width: screenWidth * 0.8, // Set a maximum width
                  child: Text(
                    article.url,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                      fontSize: 14 * textScaleFactor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
