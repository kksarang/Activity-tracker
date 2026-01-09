import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/friends/presentation/providers/group_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  ConsumerState<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final Set<String> _selectedFriends = {};

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final groupState = ref.watch(groupProvider);
    final friends = groupState.friends;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Group',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group Name Input
              Text(
                'Group Details',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration:
                          AppTheme.glassDecoration(
                            isDark: isDark,
                            radius: 16,
                          ).copyWith(
                            color: isDark
                                ? AppColors.darkGlassOverlay
                                : Colors.grey.withOpacity(0.05),
                            border: Border.all(color: Colors.transparent),
                          ),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Group Name (e.g. Vegas Trip)',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Member Selection
              Text(
                'Add Members',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final friend = friends[index];
                    final isSelected = _selectedFriends.contains(friend.id);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedFriends.remove(friend.id);
                          } else {
                            _selectedFriends.add(friend.id);
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration:
                            AppTheme.glassDecoration(
                              isDark: isDark,
                              radius: 16,
                            ).copyWith(
                              color: isSelected
                                  ? AppColors.primaryPurple.withOpacity(0.1)
                                  : (isDark
                                        ? AppColors.darkGlassOverlay
                                        : Colors.white),
                              border: isSelected
                                  ? Border.all(color: AppColors.primaryPurple)
                                  : null,
                            ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(friend.avatarUrl),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              friend.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primaryPurple,
                              )
                            else
                              const Icon(
                                Icons.circle_outlined,
                                color: Colors.grey,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Proceed Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a group name'),
                        ),
                      );
                      return;
                    }
                    if (_selectedFriends.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select at least one member'),
                        ),
                      );
                      return;
                    }

                    ref
                        .read(groupProvider.notifier)
                        .addGroup(
                          _nameController.text,
                          _selectedFriends.toList(),
                        );

                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Group created successfully!'),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Create Group (${_selectedFriends.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
