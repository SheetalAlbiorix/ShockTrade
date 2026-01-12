import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/news/presentation/widgets/news_card.dart';
import 'package:shock_app/features/news/presentation/widgets/news_filter_chip.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.premiumBackgroundDark, // Matches background-dark from HTML
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            const _NewsHeader(),

            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Filter Chips (Sticky-like behavior handled by placement for now)
                    // In a simpler scroll view, placing it at the top works.
                    // For true sticky header used inside a CustomScrollView with SliverPersistentHeader,
                    // but standard column is OK for this scope unless user demanded sticky.
                    // HTML says "sticky top-0". Let's stick with Column for simplicity first.
                    const _FilterSection(),

                    const SizedBox(height: 16),

                    // News Feed
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: const [
                          // Item 1
                          NewsCard(
                            title: 'HDFC Bank Q3 profit jumps 33% on strong loan growth, beats estimates',
                            source: 'ET Markets',
                            timeAgo: '15m ago',
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA-Y-r6GodP7S4rJCcYu7gpmcv4wK_jXbMnc8h67zOE7NfFrsxjto11KW7Wyk4CWzQbmP7zJEuaWmIVAIcrS-zyLJ2HnUNkstGuWTI11MtqIIZttBhTNwlNVDtWk_qY5tOTwmtGXDI5VTu4WeDSL2FLHHYWEA90DFMHA2LD54d9saEHRMFNljuFcezjYdcwpB2g7Yf5jzd86UdZnU92kR-ghel2FwSlRiHLP82uJDZ4WmEdfbFGJ17Qqxx5puXo_O_HP55i5tRBLQE',
                            tag: 'HDFCBANK',
                            trendValue: '1.2%',
                            isBullish: true,
                          ),
                          SizedBox(height: 16),
                          
                          // Item 2
                          NewsCard(
                            title: 'Adani Ports to raise \$500M via dollar bonds next week for expansion',
                            source: 'Bloomberg',
                            timeAgo: '1h ago',
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBgFe53RQwri76tXsFRflcOiupSiPBi_y4CahxgVUZpGd0qAuXYHLGaDGJEu6ocerwpqAzHmhx9rPt0ZsaqNwTsjpXKgVKb9OaRhl6bzvE-grAX_BQ-Nnoz1vn8TnCo8qw1C3n4Ze3CtpkPLDjQQOIZxRy_nLIA-9MvA_GTZdhAiFGllaj0O_V9D5P_UBbWpL3oTl7GijAea27URykkO2Wi9oHNKHA8ehuaoYHPMINgOVSA9jyvmP3uPRtSdVO1mVTWVCEVFF2SmVY',
                            tag: 'ADANIPORTS',
                            trendValue: '0.5%',
                            isBullish: false,
                          ),
                          SizedBox(height: 16),

                          // Item 3
                          NewsCard(
                            title: 'TCS secures major multi-year deal with UK insurer Aviva to transform cloud infrastructure',
                            source: 'LiveMint',
                            timeAgo: '2h ago',
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBQsc_M3GWQTkEF70XUJibkC6ZlGLIGwmjAQ-o8D9F5J6A0ST1XCgSbsHKYVHorruzJf4hWqkf9y2QWdGtWqjL5Gb-ByRfOZKl9RpMQwFYRVZ4aRuslhWfQhK9R0cI4ttJEM-7ekwd7fPBQb9pyFmQO_BX_v31LQS8r3-DZSFD1EbUGfUVUoLyzMqDo-LVvFZ0ucblxK9XEf2F-8LrH713WX0sUSu30I9obQRplhwwDcYjkAefNyETPiJnKtNKzKfMRjvUADegXwDQ',
                            tag: 'TCS',
                            trendValue: '0.8%',
                            isBullish: true,
                          ),
                          SizedBox(height: 16),

                          // Item 4
                          NewsCard(
                            title: 'Market Wrap: Sensex ends volatile session flat, IT stocks gain while Metals drag',
                            source: 'CNBC-TV18',
                            timeAgo: '4h ago',
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBg4ff4ekovHNWEG2Z-9GTyJJIssDUBu2ciYRID3ESU8lsXPJ3F8f2FY2C-lu1AH3UdCu1vzka7HtNIr99KRwULl84s_XgdFPmnT3UPOD7nymxDwWCUhVluTnm2QwzVVz8RpBRiFrI2NTiDYj61PtqtM83kIqrW7L6vbkmqqXm8dzDJP6ojNBNg8gLZV-i_PbVgkdFFFGpt0UTKdFqGeb05hxxArXRGAtYLSCtmTWEx5aVduh5f_Itoyh7f4L6VnialnBx3vC7j_W0',
                            tag: 'SENSEX',
                            trendValue: '0.1%',
                            isBullish: false,
                          ),
                          SizedBox(height: 16),

                          // Item 5
                          NewsCard(
                            title: 'Retail inflation eases to 3-month low of 5.1% in January',
                            source: 'Reuters',
                            timeAgo: '5h ago',
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAyyhcr0QOyil5roqKr7gHCQEFGkGIwpkcXBp-Fklf1mgZs92e2Nj91yAXxdGPoj8rpaxV9mHb9JkCIC6iwytaE7fH_NJONcB2H3ddiuU9tho1eZdlj5JI7nwfaKeaNOAUqtIbjclU8-2SDPs_KwXc4P-29KD6UX4g447foTHtKuPQmtoyrFMop-ePvss-r2D5glyiox1zUQZgNBBJxk8wlX70vvTD0onNO_fst1CNlEufnD4fehuMjz5-rAJJ6HIs_4fhqdccbKXQ',
                            tag: 'ECONOMY',
                          ),
                          SizedBox(height: 32),
                        ],
                      ),
                    ),

                    // Loading State
                    const _LoadingIndicator(),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsHeader extends StatelessWidget {
  const _NewsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.premiumBackgroundDark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent, // or hover color
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            ),
          ),
          
          const Text(
            'Market News',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          // Search Button
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection();

  @override
  Widget build(BuildContext context) {
    final List<String> filters = [
      'Top Stories',
      'Nifty 50',
      'Earnings',
      'Global',
      'Commodities',
      'IPOs'
    ];

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: AppColors.premiumBackgroundDark.withOpacity(0.95), // backdrop blur sim
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = index == 0; // First one selected by default
          return NewsFilterChip(
            label: filters[index],
            isSelected: isSelected,
            onTap: () {},
          );
        },
      ),
    );
  }
}

class _LoadingIndicator extends StatefulWidget {
  const _LoadingIndicator();

  @override
  State<_LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<_LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return FadeTransition(
          opacity: _controller.drive(
            CurveTween(curve: Interval(index * 0.2, 1.0, curve: Curves.easeIn)),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.neutralGray,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}
