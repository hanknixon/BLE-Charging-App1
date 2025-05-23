import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../navigation/navbars.dart';

class CommunityV extends StatefulWidget {
  @override
  _CommunityVState createState() => _CommunityVState();
}

class _CommunityVState extends State<CommunityV>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildReviewCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MCConstants.ctaBtnCornerRadius),
        border: Border.all(color: MCColors.greyLight),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Downtown Charging Station',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MCColors.green,
                  ),
                ),
                Row(
                  children: List.generate(
                      5,
                      (index) => Icon(Icons.star,
                          size: 16,
                          color:
                              index < 4 ? MCColors.green : MCColors.greyLight)),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Great location, all chargers working well. The staff was very helpful when I had trouble connecting...',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: MCColors.grey),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '2 hours ago',
                  style: TextStyle(
                    color: MCColors.grey,
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View more',
                    style: TextStyle(
                      color: MCColors.green,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: MCColors.greenLight,
        borderRadius: BorderRadius.circular(MCConstants.ctaBtnCornerRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MCColors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.access_time, color: MCColors.green),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Central Mall Charging Hub',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MCColors.green,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Peak hours, 3/4 chargers occupied',
                    style: TextStyle(color: MCColors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '15 minutes ago',
                    style: TextStyle(
                      fontSize: 12,
                      color: MCColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscussionCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MCConstants.ctaBtnCornerRadius),
        border: Border.all(color: MCColors.greyLight),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: MCColors.green,
                  child: Text('JD', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hank Nixon',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MCColors.green,
                      ),
                    ),
                    Text(
                      '1 hour ago',
                      style: TextStyle(
                        fontSize: 12,
                        color: MCColors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Best practices for winter charging',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: MCColors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Here are some tips Ive learned about charging in cold weather...',
              style: TextStyle(color: MCColors.grey),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: MCColors.greenLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '#ChargingTips',
                    style: TextStyle(
                      color: MCColors.green,
                      fontSize: 12,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.thumb_up_outlined, color: MCColors.grey),
                  onPressed: () {},
                ),
                Text('24', style: TextStyle(color: MCColors.grey)),
                IconButton(
                  icon: Icon(Icons.chat_bubble_outline, color: MCColors.grey),
                  onPressed: () {},
                ),
                Text('8', style: TextStyle(color: MCColors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCColors.white,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TopNavBar(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: MCColors.greyLight, width: 1),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Community",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: MCColors.green,
                    letterSpacing: MCConstants.letterSpacing1,
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: MCColors.green,
            unselectedLabelColor: MCColors.grey,
            indicatorColor: MCColors.green,
            tabs: [
              Tab(text: 'Reviews'),
              Tab(text: 'Status'),
              Tab(text: 'Discussion'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Reviews Tab
                ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: OutlinedButton.icon(
                        icon: Icon(Icons.rate_review, color: MCColors.green),
                        label: Text(
                          'Write a Review',
                          style: TextStyle(color: MCColors.green),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: MCColors.green),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                MCConstants.ctaBtnCornerRadius),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    _buildReviewCard(),
                    _buildReviewCard(),
                    _buildReviewCard(),
                  ],
                ),
                // Status Tab
                ListView(
                  children: [
                    _buildStatusCard(),
                    _buildStatusCard(),
                    _buildStatusCard(),
                  ],
                ),
                // Discussion Tab
                ListView(
                  children: [
                    _buildDiscussionCard(),
                    _buildDiscussionCard(),
                    _buildDiscussionCard(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MCColors.green,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}
