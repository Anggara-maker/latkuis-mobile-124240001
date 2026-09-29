import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../models/menu.dart';
import 'detail_menu_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({
    super.key,
    required this.username,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final TextEditingController _searchController =
      TextEditingController();

  String _selectedCategory = "Semua";

  final List<Menu> _favoriteMenus = [];

  List<String> get _categories {
    final categories =
        menus.map((menu) => menu.category).toSet().toList();

    return ["Semua", ...categories];
  }

  List<Menu> get _filteredMenus {
    return menus.where((menu) {
      final matchesSearch = menu.name
          .toLowerCase()
          .contains(
            _searchController.text.toLowerCase(),
          );

      final matchesCategory =
          _selectedCategory == "Semua" ||
          menu.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _toggleFavorite(Menu menu) {
    setState(() {
      if (_favoriteMenus.contains(menu)) {
        _favoriteMenus.remove(menu);
      } else {
        _favoriteMenus.add(menu);
      }
    });
  }

  bool _isFavorite(Menu menu) {
    return _favoriteMenus.contains(menu);
  }

  void _openDetail(Menu menu) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailMenuScreen(
          menu: menu,
          isFavorite: _isFavorite(menu),
          onFavoriteChanged: () {
            _toggleFavorite(menu);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

Widget _buildHomePage() {
  return SafeArea(
    child: ListView(
      padding: const EdgeInsets.only(bottom: 20),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2F5F7),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF006D7A),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo, ${widget.username}!",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF17343A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Mau makan apa hari ini?",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Icon(
                        Icons.favorite_outline,
                        color: Color(0xFF006D7A),
                      ),
                    ),
                    if (_favoriteMenus.isNotEmpty)
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          width: 16,
                          height: 16,
                          alignment: Alignment.center,
                          decoration:
                              const BoxDecoration(
                            color: Color(0xFF006D7A),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${_favoriteMenus.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF006D7A),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nikmati Menu\nFavoritmu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Temukan berbagai pilihan menu Gacoan.",
                        style: TextStyle(
                          color: Colors.white.withValues(
                            alpha: 0.85,
                          ),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 65,
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            5,
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (_) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: "Cari menu...",
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF006D7A),
              ),
              suffixIcon:
                  _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close),
                        )
                      : null,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        SizedBox(
          height: 55,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              5,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];

              final isSelected =
                  _selectedCategory == category;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  selectedColor:
                      const Color(0xFF006D7A),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                  side: BorderSide.none,
                ),
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            5,
          ),
          child: _filteredMenus.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 60,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Menu tidak ditemukan",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: _filteredMenus.length,
                  itemBuilder: (context, index) {
                    final menu = _filteredMenus[index];

                    return TweenAnimationBuilder<double>(
                      duration: Duration(
                        milliseconds: 250 + (index * 50),
                      ),
                      tween: Tween(
                        begin: 0,
                        end: 1,
                      ),
                      builder: (
                        context,
                        value,
                        child,
                      ) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(
                              0,
                              20 * (1 - value),
                            ),
                            child: child,
                          ),
                        );
                      },
                      child: _buildMenuCard(menu),
                    );
                  },
                ),
        ),
      ],
    ),
  );
}

  Widget _buildMenuCard(Menu menu) {
    final isFavorite = _isFavorite(menu);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius:
              BorderRadius.circular(18),
          onTap: () => _openDetail(menu),
          child: Padding(
            padding: const EdgeInsets.all(11),
            child: Row(
              children: [
                Hero(
                  tag: "menu-${menu.id}",
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(14),
                    child: Image.network(
                      menu.image,
                      width: 95,
                      height: 95,
                      fit: BoxFit.cover,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Container(
                          width: 95,
                          height: 95,
                          color: const Color(0xFFEFF5F5),
                          child: const Icon(
                            Icons
                                .image_not_supported_outlined,
                            color: Color(0xFF006D7A),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu.name,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF17343A),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFE2F5F7),
                          borderRadius:
                              BorderRadius.circular(7),
                        ),
                        child: Text(
                          menu.category,
                          style: const TextStyle(
                            color: Color(0xFF006D7A),
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        menu.price,
                        style: const TextStyle(
                          color: Color(0xFF006D7A),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        _toggleFavorite(menu);
                      },
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
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          key: ValueKey(isFavorite),
                          color: const Color(0xFF006D7A),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritePage() {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              5,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Favorite",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF17343A),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              0,
              20,
              15,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${_favoriteMenus.length} menu disukai",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
          Expanded(
            child: _favoriteMenus.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFE2F5F7),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            size: 45,
                            color: Color(0xFF006D7A),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Belum ada menu favorite",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          "Tambahkan menu yang kamu sukai.",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.fromLTRB(
                      20,
                      5,
                      20,
                      25,
                    ),
                    itemCount: _favoriteMenus.length,
                    itemBuilder: (context, index) {
                      return _buildMenuCard(
                        _favoriteMenus[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePage() {
    return ProfileScreen(
      username: widget.username,
      showAppBar: false,
      onLogout: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      },
    );
  }

  Widget _getPage() {
    if (_selectedIndex == 0) {
      return _buildHomePage();
    }

    if (_selectedIndex == 1) {
      return _buildFavoritePage();
    }

    return _buildProfilePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE2F5F7),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(
              Icons.home,
              color: Color(0xFF006D7A),
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(
              Icons.favorite,
              color: Color(0xFF006D7A),
            ),
            label: "Favorite",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(
              Icons.person,
              color: Color(0xFF006D7A),
            ),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}