import 'package:flutter/material.dart';
import '../models/menu.dart';

class DetailMenuScreen extends StatefulWidget {
  final Menu menu;
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;

  const DetailMenuScreen({
    super.key,
    required this.menu,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  State<DetailMenuScreen> createState() =>
      _DetailMenuScreenState();
}

class _DetailMenuScreenState
    extends State<DetailMenuScreen> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    widget.onFavoriteChanged();
  }

  @override
  Widget build(BuildContext context) {
    final menu = widget.menu;

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: const Color(0xFF006D7A),
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: _toggleFavorite,
                icon: AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  transitionBuilder: (
                    child,
                    animation,
                  ) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: Icon(
                    _isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    key: ValueKey(_isFavorite),
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: "menu-${menu.id}",
                child: Image.network(
                  menu.image,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons
                            .image_not_supported_outlined,
                        size: 60,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                25,
                20,
                30,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF17343A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFE2F5F7),
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: Text(
                          menu.category,
                          style: const TextStyle(
                            color: Color(0xFF006D7A),
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        menu.price,
                        style: const TextStyle(
                          color: Color(0xFF006D7A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons
                                  .description_outlined,
                              color: Color(0xFF006D7A),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Deskripsi Menu",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                                color:
                                    Color(0xFF17343A),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          menu.description,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text(
                        "Kembali ke Menu",
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                            const Color(0xFF006D7A),
                        side: const BorderSide(
                          color: Color(0xFF006D7A),
                        ),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}