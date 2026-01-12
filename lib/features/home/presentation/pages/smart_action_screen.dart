import 'package:activity/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum SmartActionType {
  payToFriend,
  settleBalance,
  walletTransfer,
  requestFromFriend,
  requestFromGroup,
}

class SmartActionScreen extends StatefulWidget {
  final SmartActionType actionType;

  const SmartActionScreen({super.key, required this.actionType});

  @override
  State<SmartActionScreen> createState() => _SmartActionScreenState();
}

class _SmartActionScreenState extends State<SmartActionScreen> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _selectedUser;
  bool _isLoading = false;
  String? _amountError;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_validateAmount);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _amountController.removeListener(_validateAmount);
    _amountController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validateAmount() {
    final text = _amountController.text;
    if (text.isEmpty) {
      setState(() => _amountError = null);
      return;
    }

    final amount = double.tryParse(text);
    if (amount == null || amount <= 0) {
      setState(() => _amountError = 'Enter a valid amount');
      return;
    }

    if (text.contains('.') && text.split('.')[1].length > 2) {
      setState(() => _amountError = 'Max 2 decimal places');
      return;
    }

    setState(() => _amountError = null);
  }

  bool get _isValid {
    if (_amountError != null) return false;
    final text = _amountController.text;
    final amount = double.tryParse(text);
    return amount != null && amount > 0;
  }

  String get _title {
    switch (widget.actionType) {
      case SmartActionType.payToFriend:
        return 'Pay to Friend';
      case SmartActionType.settleBalance:
        return 'Settle Balance';
      case SmartActionType.walletTransfer:
        return 'Wallet Transfer';
      case SmartActionType.requestFromFriend:
        return 'Request from Friend';
      case SmartActionType.requestFromGroup:
        return 'Request from Group';
    }
  }

  String get _actionButtonText {
    switch (widget.actionType) {
      case SmartActionType.payToFriend:
        return 'Pay Now';
      case SmartActionType.settleBalance:
        return 'Settle';
      case SmartActionType.walletTransfer:
        return 'Transfer';
      case SmartActionType.requestFromFriend:
      case SmartActionType.requestFromGroup:
        return 'Request';
    }
  }

  Color get _themeColor {
    switch (widget.actionType) {
      case SmartActionType.payToFriend:
      case SmartActionType.settleBalance:
      case SmartActionType.walletTransfer:
        return AppColors.primaryPurple;
      case SmartActionType.requestFromFriend:
      case SmartActionType.requestFromGroup:
        return const Color(
          0xFF6B4C9A,
        ); // Slightly different shade or blue? sticking to theme for now
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1E212B)
          : const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),

          // Amount Input
          Center(
            child: Column(
              children: [
                Text(
                  'Enter Amount',
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                IntrinsicWidth(
                  child: TextField(
                    controller: _amountController,
                    focusNode: _focusNode,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      prefixText: '₹',
                      prefixStyle: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      border: InputBorder.none,
                      hintText: '0',
                      hintStyle: TextStyle(
                        color: isDark ? Colors.white24 : Colors.black12,
                      ),
                      errorText: _amountError,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),

          // User Selection (Dummy Data)
          if (widget.actionType != SmartActionType.walletTransfer) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.actionType == SmartActionType.requestFromGroup
                      ? 'Select Group'
                      : 'Select Person',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final names = ['Alice', 'Bob', 'Charlie', 'David', 'Eve'];
                  final isSelected = _selectedUser == names[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedUser = names[index];
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? _themeColor
                                : (isDark
                                      ? Colors.grey[800]
                                      : Colors.grey[200]),
                            border: isSelected
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                          ),
                          child: Icon(
                            widget.actionType ==
                                    SmartActionType.requestFromGroup
                                ? Icons.group
                                : Icons.person,
                            color: isSelected
                                ? Colors.white
                                : (isDark ? Colors.white54 : Colors.black54),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          names[index],
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? _themeColor
                                : (isDark ? Colors.white70 : Colors.black87),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],

          const Spacer(),

          // Action Button
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: (_isValid && !_isLoading)
                    ? () async {
                        setState(() => _isLoading = true);

                        // Fake processing
                        await Future.delayed(const Duration(seconds: 1));

                        if (mounted) {
                          setState(() => _isLoading = false);
                          context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Success! Action completed.'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    : null,
                style: FilledButton.styleFrom(
                  backgroundColor: _themeColor,
                  disabledBackgroundColor: _themeColor.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        _actionButtonText,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
