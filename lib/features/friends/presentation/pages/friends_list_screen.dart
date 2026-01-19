import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/friends/presentation/providers/friends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FriendsListScreen extends ConsumerStatefulWidget {
  const FriendsListScreen({super.key});

  @override
  ConsumerState<FriendsListScreen> createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends ConsumerState<FriendsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _showInviteSheet(BuildContext context) {
    // Generate invite on open
    ref.read(friendsProvider.notifier).generateInvite();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const _InviteBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(friendsProvider);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
      appBar: AppBar(
        title: Text(
          'Friends',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_add_alt_1_rounded,
              color: AppColors.primaryPurple,
            ),
            onPressed: () => _showInviteSheet(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryPurple,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primaryPurple,
          tabs: [
            Tab(text: 'My Friends (${state.friends.length})'),
            Tab(text: 'Requests (${state.requests.length})'),
          ],
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildFriendsList(state.friends, isDark),
                _buildRequestsList(state.requests, isDark),
              ],
            ),
    );
  }

  Widget _buildFriendsList(List friends, bool isDark) {
    if (friends.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: Colors.grey.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            const Text('No friends yet', style: TextStyle(color: Colors.grey)),
            TextButton(
              onPressed: () => _showInviteSheet(context),
              child: const Text('Invite someone!'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.withValues(alpha: 0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(friend.avatarUrl),
            ),
            title: Text(
              friend.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(friend.email, style: const TextStyle(fontSize: 12)),
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }

  Widget _buildRequestsList(List requests, bool isDark) {
    if (requests.isEmpty) {
      return Center(
        child: Text(
          'No new requests',
          style: TextStyle(color: Colors.grey.withValues(alpha: 0.5)),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final friend = requests[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.withValues(alpha: 0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(friend.avatarUrl)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        friend.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Wants to connect',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(friendsProvider.notifier).acceptRequest(friend.id);
                  },
                  child: const Text('Accept'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InviteBottomSheet extends ConsumerWidget {
  const _InviteBottomSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(friendsProvider);
    final invite = state.activeInvite;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Invite Friends',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Share this link to add friends instantly.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),

          if (invite == null)
            const CircularProgressIndicator()
          else
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primaryPurple.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.link, color: AppColors.primaryPurple),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      invite.dynamicLink,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryPurple,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: invite.dynamicLink),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Link copied!')),
                      );
                    },
                  ),
                ],
              ),
            ),

          const SizedBox(height: 24),
          // Simulate receiving a deep link (For Demo)
          OutlinedButton(
            onPressed: () {
              // Simulate checking a deep link
              ref.read(friendsProvider.notifier).simulateDeepLink('ABC1234');
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Simulated: Friend Accepted Invite!'),
                ),
              );
            },
            child: const Text('Developer: Simulate Receive Invite'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
