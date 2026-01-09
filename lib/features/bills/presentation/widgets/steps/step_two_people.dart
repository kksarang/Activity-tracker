import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/bills/presentation/providers/split_bill_provider.dart';
import 'package:activity/features/friends/presentation/providers/group_provider.dart';
import 'package:activity/features/friends/domain/user_model.dart';
import 'package:activity/features/friends/domain/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StepTwoPeople extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const StepTwoPeople({super.key, required this.onNext});

  @override
  ConsumerState<StepTwoPeople> createState() => _StepTwoPeopleState();
}

class _StepTwoPeopleState extends ConsumerState<StepTwoPeople> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  void _toggleParticipant(UserModel user) {
    final state = ref.read(splitBillProvider);
    final isSelected = state.participants.any((p) => p.id == user.id);

    if (isSelected) {
      ref.read(splitBillProvider.notifier).removeParticipant(user.id);
    } else {
      ref.read(splitBillProvider.notifier).addParticipant(user);
    }
  }

  void _addGroupMembers(GroupModel group) {
    final notifier = ref.read(splitBillProvider.notifier);
    for (var member in group.members) {
      notifier.addParticipant(member);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added ${group.members.length} members from ${group.name}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Watch providers
    final splitState = ref.watch(splitBillProvider);
    final groupState = ref.watch(groupProvider);

    final selectedParticipants = splitState.participants;
    final isValid = selectedParticipants.isNotEmpty;

    // Filter Logic
    final filteredFriends = groupState.friends.where((user) {
      return user.name.toLowerCase().contains(_searchQuery);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose people\ninvolved in this split.',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Search for a name in your phonebook or add someone new via mobile number',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF2C2C2E)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Name or Number',
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Horizontal Selected List
        if (selectedParticipants.isNotEmpty)
          SizedBox(
            height: 90,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: selectedParticipants.length,
              itemBuilder: (context, index) {
                final user = selectedParticipants[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(user.avatarUrl),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () => _toggleParticipant(user),
                              child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.name.split(' ').first,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

        if (selectedParticipants.isNotEmpty) const Divider(),

        // Vertical List
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              // Create Group Option
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2C2C2E) : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.group_add_outlined,
                    color: AppColors.primaryPurple,
                  ),
                ),
                title: const Text(
                  'Create new group',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  context.push('/create-group');
                },
              ),
              const SizedBox(height: 16),

              // Groups Section
              if (groupState.groups.isNotEmpty) ...[
                Text(
                  'Your Groups',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...groupState.groups.map((group) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.groups, color: Colors.orange),
                    ),
                    title: Text(
                      group.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${group.members.length} members',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: OutlinedButton(
                      onPressed: () => _addGroupMembers(group),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: const Text('Add'),
                    ),
                  );
                }),
                const SizedBox(height: 24),
              ],

              // Friends Section
              Text(
                'All Friends',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (filteredFriends.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: Text('No friends found')),
                )
              else
                ...filteredFriends.map((user) {
                  final isSelected = selectedParticipants.any(
                    (p) => p.id == user.id,
                  );
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                    title: Text(
                      user.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      user.email ?? '+91 98765 43210',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check_circle,
                            color: AppColors.primaryPurple,
                          )
                        : OutlinedButton(
                            onPressed: () => _toggleParticipant(user),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              side: const BorderSide(color: Colors.grey),
                            ),
                            child: const Text('Add'),
                          ),
                  );
                }),
            ],
          ),
        ),

        // Bottom CTA
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: isValid ? widget.onNext : null,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                disabledBackgroundColor: isDark
                    ? Colors.grey[800]
                    : Colors.grey[300],
              ),
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
