import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../navigation/navbars.dart';

class PaymentMethodsV extends StatelessWidget {
  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      type: PaymentType.visa,
      lastFour: "4582",
      expiryDate: "12/25",
      isDefault: true,
      nickname: "Personal Card",
    ),
    PaymentMethod(
      type: PaymentType.mastercard,
      lastFour: "8845",
      expiryDate: "09/24",
      isDefault: false,
      nickname: "Business Card",
    ),
    PaymentMethod(
      type: PaymentType.paypal,
      email: "hank.nixon@gmail.com",
      isDefault: false,
      nickname: "PayPal Account",
    ),
  ];

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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: MCColors.green),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          "Payment Methods",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: MCColors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: paymentMethods.length,
                    itemBuilder: (context, index) {
                      final method = paymentMethods[index];
                      return _buildPaymentMethodCard(context, method);
                    },
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(double.infinity, 56),
                        side: BorderSide(color: MCColors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              MCConstants.ctaBtnCornerRadius),
                        ),
                      ),
                      onPressed: () {
                        _showAddPaymentMethodDialog(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: MCColors.green),
                          SizedBox(width: 8),
                          Text(
                            "Add Payment Method",
                            style: TextStyle(
                              color: MCColors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _buildPaymentMethodCard(BuildContext context, PaymentMethod method) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: MCColors.greenLight,
        borderRadius: BorderRadius.circular(MCConstants.ctaBtnCornerRadius),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: _getPaymentTypeIcon(method.type),
        title: Text(
          method.nickname,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MCColors.green,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              method.type == PaymentType.paypal
                  ? method.email!
                  : '•••• ${method.lastFour}',
              style: TextStyle(color: MCColors.grey),
            ),
            if (method.type != PaymentType.paypal) ...[
              SizedBox(height: 4),
              Text(
                'Expires ${method.expiryDate}',
                style: TextStyle(color: MCColors.grey),
              ),
            ],
            if (method.isDefault) ...[
              SizedBox(height: 4),
              Text(
                'Default',
                style: TextStyle(
                  color: MCColors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
        trailing: PopupMenuButton(
          icon: Icon(Icons.more_vert, color: MCColors.grey),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('Set as Default'),
              value: 'default',
            ),
            PopupMenuItem(
              child: Text('Edit'),
              value: 'edit',
            ),
            PopupMenuItem(
              child: Text('Delete'),
              value: 'delete',
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'default':
                _showSetDefaultDialog(context);
                break;
              case 'edit':
                _showEditPaymentMethodDialog(context, method);
                break;
              case 'delete':
                _showDeleteConfirmationDialog(context);
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _getPaymentTypeIcon(PaymentType type) {
    IconData iconData;
    switch (type) {
      case PaymentType.visa:
        iconData = Icons.credit_card;
        break;
      case PaymentType.mastercard:
        iconData = Icons.credit_card;
        break;
      case PaymentType.paypal:
        iconData = Icons.account_balance_wallet;
        break;
    }
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MCColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: MCColors.green, size: 24),
    );
  }

  void _showAddPaymentMethodDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MCColors.green,
              ),
            ),
            SizedBox(height: 24),
            _buildPaymentOption(
              context,
              'Credit or Debit Card',
              Icons.credit_card,
              () => Navigator.pop(context),
            ),
            SizedBox(height: 16),
            _buildPaymentOption(
              context,
              'PayPal',
              Icons.account_balance_wallet,
              () => Navigator.pop(context),
            ),
            SizedBox(height: 16),
            _buildPaymentOption(
              context,
              'Google Pay',
              Icons.g_mobiledata,
              () => Navigator.pop(context),
            ),
            SizedBox(height: 16),
            _buildPaymentOption(
              context,
              'Apple Pay',
              Icons.apple,
              () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: MCColors.greyLight),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: MCColors.green),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: MCColors.grey,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: MCColors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  void _showEditPaymentMethodDialog(
      BuildContext context, PaymentMethod method) {
    // Implement edit payment method dialog
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Payment Method'),
        content: Text('Are you sure you want to delete this payment method?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              'Delete',
              style: TextStyle(color: MCColors.errorRed),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showSetDefaultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set as Default'),
        content: Text('Set this as your default payment method?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              'Set Default',
              style: TextStyle(color: MCColors.green),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

enum PaymentType { visa, mastercard, paypal }

class PaymentMethod {
  final PaymentType type;
  final String? lastFour;
  final String? expiryDate;
  final String? email;
  final bool isDefault;
  final String nickname;

  PaymentMethod({
    required this.type,
    this.lastFour,
    this.expiryDate,
    this.email,
    required this.isDefault,
    required this.nickname,
  });
}
