import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '/data/gallery-data.dart';
import '/data/view-artist-data.dart';
import '/data/viewings-data.dart';
import '/data/main-data.dart';
import '/ui/widgets/item_featured.dart';
import '/ui/widgets/item_list.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              expandedHeight: size.height * 0.3,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(8.0),
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                title: AutoSizeText(
                  "National Museum of Fine Arts",
                  textAlign: TextAlign.end,
                  maxFontSize: 30,
                  maxLines: 2,
                  style: GoogleFonts.openSansCondensed(
                      fontSize: 25
                  ),
                ),
                centerTitle: true,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/Off-NMP.png',
                      fit: BoxFit.cover,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.white.withAlpha(0),
                            Colors.white12,
                            Colors.white38,
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headline('Featured Artwork'), // Modified the headline method call
                  ),
                  FutureBuilder(
                    future: ViewDatabaseHelper.instance.getViewPaintingsById('9'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return FeaturedTile(
                          viewpaintings: snapshot.data as ViewPaintings, // Changed snapshot data type to Artworks
                          tileHeight: size.height * 0.35,
                          tileWidth: size.width,
                        );
                      }
                      return Container();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headline('Artworks'), // Modified the headline method call
                  ),
                  FutureBuilder(
                    future:ViewDatabaseHelper.instance.getAllViewPaintings(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ViewPaintings> artworks = snapshot.data as List<ViewPaintings>;
                        return ListHorizontal(
                          itemList: artworks,
                        );// Replaced ItemList with the appropriate widget and passed artworks as an argument
                      }
                      return Container();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headline('Artists'), // Modified the headline method call
                  ),
                  FutureBuilder(
                    future: ViewArtistDatabaseHelper.instance.getAllViewArtist(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ViewArtist> artists = snapshot.data as List<ViewArtist>;
                        return ListHorizontal(
                          itemList: artists,
                        );// Replaced ItemList with the appropriate widget and passed artworks as an argument
                      }
                      return Container();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headline('Gallery'), // Modified the headline method call
                  ),
                  FutureBuilder(
                    future: GalleryDatabaseHelper.instance.getAllGallery(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Gallery> gallery = snapshot.data as List<Gallery>;
                        return ListHorizontal(
                          itemList: gallery,
                        );// Replaced ItemList with the appropriate widget and passed artworks as an argument
                      }
                      return Container();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headline('Hallway Artworks'), // Modified the headline method call
                  ),
                  FutureBuilder(
                    future: ArtworksDatabaseHelper.instance.getAllArtworks(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Artworks> artists = snapshot.data as List<Artworks>;
                        return ListHorizontal(
                          itemList: artists,
                        );// Replaced ItemList with the appropriate widget and passed artworks as an argument
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget headline(String text) => Text(
  text.toUpperCase(),
  style: GoogleFonts.openSansCondensed(fontSize: 25),
);

