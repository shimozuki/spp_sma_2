// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_ewallet/controller/history_controller.dart';
import 'package:flutter_ewallet/controller/tagihan_controller.dart';
import 'package:flutter_ewallet/models/history_model.dart';
import 'package:flutter_ewallet/models/tagihan_model.dart';
import 'package:flutter_ewallet/ui/widgets/custom_card_friendly.dart';
import 'package:flutter_ewallet/ui/widgets/custom_home_services.dart';
import 'package:flutter_ewallet/ui/widgets/custom_latest_transaction_item.dart';
import 'package:flutter_ewallet/ui/widgets/custom_user.dart';
import 'package:flutter_ewallet/utils/shared.dart';
import 'package:flutter_ewallet/utils/theme.dart';

class HomePage extends StatelessWidget {
   const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HistoryController _historyController = HistoryController();
    final List numbers = ['1', '2', '3', '5'];
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: customBottomAppBar(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showImageDialog(context);
          },
          backgroundColor: purpleColor,
          child: Image.asset(
            'assets/ic_plus_circle.png',
            width: 24,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: FutureBuilder<List<HistoryData>>(
          future: _historyController.getHistory(), // Call the getHistory method
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<HistoryData> transactions = snapshot.data ?? [];
              return SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildProfileSection(context),
                        buildCardBank(),
                        buildLatestTransaction(context, transactions),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            height: 480,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage('assets/IMG-20231227-WA0170.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildFriendlyTips() {
  return Container(
    margin: const EdgeInsets.only(top: 30, bottom: 50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Friendly Tips',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Wrap(
          spacing: 17,
          runSpacing: 18,
          children: [
            FriendlyCustomCard(
              imageUrl: 'assets/img_tips1.png',
              title: 'Best tips for using a credit card',
              url: 'https://www.google.com',
            ),
            FriendlyCustomCard(
                imageUrl: 'assets/img_tips2.png',
                title: 'Spot the good pie of finance model',
                url: 'https://www.pub.dev'),
            FriendlyCustomCard(
                imageUrl: 'assets/img_tips3.png',
                title: 'Great hack to get better advices',
                url: 'https://www.google.com'),
            FriendlyCustomCard(
                imageUrl: 'assets/img_tips4.png',
                title: 'Save more penny buy this instead',
                url: 'https://www.google.com'),
          ],
        ),
      ],
    ),
  );
}

Widget buildSendAgain() {
  return Container(
    margin: const EdgeInsets.only(top: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Send Again',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              CustomUser(
                imageUrl: 'assets/img_friend1.png',
                userName: '@yuanita',
              ),
              CustomUser(
                imageUrl: 'assets/img_friend2.png',
                userName: '@jani',
              ),
              CustomUser(
                imageUrl: 'assets/img_friend3.png',
                userName: '@uripz',
              ),
              CustomUser(
                imageUrl: 'assets/img_friend4.png',
                userName: '@maxx',
              ),
              CustomUser(
                imageUrl: 'assets/img_friend1.png',
                userName: '@johndoe',
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildLatestTransaction(BuildContext context, List<HistoryData> transactions) {
  return Container(
    margin: const EdgeInsets.only(top: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest Transaction',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 14),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: whiteColor,
          ),
          child: Column(
            children: transactions.map((transaction) {
              return LatestTransactionItem(
                iconUrl: 'assets/ic_transaction_cat3.png',
                title: 'Pembayaran',
                time: transaction.month,
                value: 'Rp.${transaction.pay}',
                onTap: () {
                  // Handle the tap action, e.g., navigate to a new page
                  Navigator.pushNamed(context, '/profile');
                },
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}


Widget buildServices(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do Something',
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomHomeServices(
              iconUrl: 'assets/ic_topup.png',
              title: 'TopUp',
              onTap: () {
                Navigator.pushNamed(context, '/topup');
              },
            ),
            CustomHomeServices(
              iconUrl: 'assets/ic_send.png',
              title: 'Send',
              onTap: () {
                Navigator.pushNamed(context, '/transfer');
              },
            ),
            CustomHomeServices(
              iconUrl: 'assets/ic_withdraw.png',
              title: 'Withdraw',
              onTap: () {},
            ),
            CustomHomeServices(
              iconUrl: 'assets/ic_more.png',
              title: 'More',
              onTap: () {
                showDialog(
                    context: context, builder: (context) => const MoreDialog());
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildProgressLevel() {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: whiteColor,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Level 1',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            const Spacer(),
            Text(
              '55%',
              style: greenTextStyle.copyWith(
                fontWeight: semiBold,
              ),
            ),
            Text(
              ' of ${formatCurrency(20000)}',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(55),
          child: LinearProgressIndicator(
            minHeight: 5,
            value: 0.55,
            color: greenColor,
            backgroundColor: lightBackgroundColor,
          ),
        ),
      ],
    ),
  );
}

Widget buildCardBank() {
   final TagihanController _tagihanController = TagihanController();
  return FutureBuilder<TagihanModel>(
      future: _tagihanController.getTagihan(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          int tagihan = snapshot.data?.data ?? 0;
          return Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/img_bg_card.png',
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ahmad',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Text(
                  '****  ****  1234',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Tagihan', style: whiteTextStyle),
                Text(
                  'Rp.${formatCurrency(tagihan, symbol: '')}',
                  style: whiteTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          );
        }
      });
}

Widget buildProfileSection(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 40),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              'Bii',
              style:
                  blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  'assets/img_profile.png',
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: whiteColor,
                ),
                child: Center(
                  child: Icon(
                    Icons.check_circle,
                    color: greenColor,
                    size: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

BottomAppBar customBottomAppBar(context) {
  return BottomAppBar(
    elevation: 0,
    color: whiteColor,
    shape: const CircularNotchedRectangle(),
    clipBehavior: Clip.antiAlias,
    notchMargin: 6,
    child: BottomNavigationBar(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: whiteColor,
      selectedItemColor: blueColor,
      unselectedItemColor: blackColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: blueTextStyle.copyWith(
        fontSize: 10,
        fontWeight: medium,
      ),
      unselectedLabelStyle: blackTextStyle.copyWith(
        fontSize: 10,
        fontWeight: medium,
      ),
      onTap: (int index) {
        if (index == 3) {
          Navigator.pushNamed(context, '/profile');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/upload-bukti');
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/ic_history.png',
            width: 20,
          ),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.upload),
          label: 'Upload',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    ),
  );
}

class MoreDialog extends StatelessWidget {
  const MoreDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      alignment: Alignment.bottomCenter,
      content: Container(
        height: 326,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: lightBackgroundColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Do More With Us",
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Wrap(
              spacing: 29,
              runSpacing: 25,
              children: [
                CustomHomeServices(
                  iconUrl: 'assets/ic_product_data.png',
                  title: 'Data',
                  onTap: () {
                    Navigator.pushNamed(context, '/data-provider');
                  },
                ),
                CustomHomeServices(
                  iconUrl: 'assets/ic_product_water.png',
                  title: 'Water',
                ),
                CustomHomeServices(
                  iconUrl: 'assets/ic_product_stream.png',
                  title: 'Stream',
                ),
                CustomHomeServices(
                  iconUrl: 'assets/ic_product_movie.png',
                  title: 'Movie',
                ),
                CustomHomeServices(
                  iconUrl: 'assets/ic_product_food.png',
                  title: 'Food',
                ),
                CustomHomeServices(
                  iconUrl: 'assets/ic_product_travel.png',
                  title: 'Travel',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
