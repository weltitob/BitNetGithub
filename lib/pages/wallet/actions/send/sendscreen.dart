import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/pages/wallet/actions/send/lightning_send_tab.dart';
import 'package:bitnet/pages/wallet/actions/send/onchain_send_tab.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

// Define a stateful widget called SendBTCScreen, which allows the user to send Bitcoin
class SendBTCScreen extends StatefulWidget {
  final String?
      bitcoinReceiverAdress; // the Bitcoin receiver address, can be null
  final String bitcoinSenderAdress; // the Bitcoin receiver address, can be null
  const SendBTCScreen(
      {Key? key, this.bitcoinReceiverAdress, required this.bitcoinSenderAdress})
      : super(key: key);

  // Create a state object for SendBTCScreen
  @override
  State<SendBTCScreen> createState() => _SendBTCScreenState();
}

// Define a state object called _SendBTCScreenState for SendBTCScreen
class _SendBTCScreenState extends State<SendBTCScreen> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // The following function builds the widget tree for the screen
  @override
  Widget build(BuildContext context) {
    // Retrieves userWallet using the Provider
    //final userWallet = Provider.of<UserWallet>(context);

    final userWallet = UserWallet(walletAddress: "fakewallet",
        walletType: "walletType", walletBalance: "0", privateKey: "privateKey", userdid: "userdid");

    // Builds the screen scaffold
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.colorBackground,
      // Disables resizing when the keyboard is shown

      appBar: bitnetAppBar(
        // Adds a back button to the appbar
        customTitle: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adds a title for the screen
            Text("Bitcoin versenden",
                style: Theme.of(context).textTheme.titleLarge),
            // Displays the user's wallet balance
            Text("${userWallet.walletBalance}BTC verfügbar",
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        context: context,
      ),
      body: Column(
        children: [
          SizedBox(
            height: AppTheme.cardPadding * 2.5,
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Lightning'),
              Tab(text: 'On chain'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                LightningSendTab(),
                OnChainSendTab(bitcoinSenderAdress: widget.bitcoinSenderAdress)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
