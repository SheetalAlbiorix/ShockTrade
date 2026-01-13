import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/services/profile_service.dart';
import 'package:shock_app/features/auth/application/providers/profile_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  // To show existing avatar if no new file selected
  String? _currentAvatarUrl;

  // Track initial values for dirty check (optimization)
  String? _initialName;
  String? _initialBio;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final profileService = ProfileService(Supabase.instance.client);
        final profile = await profileService.getProfile(user.uid);

        if (profile != null) {
          _nameController.text = profile['full_name'] ?? user.displayName ?? '';
          _emailController.text = profile['email'] ?? user.email ?? '';
          _bioController.text = profile['bio'] ?? '';
          _currentAvatarUrl = profile['avatar_url'] ?? user.photoURL;

          _initialName = _nameController.text;
          _initialBio = _bioController.text;
        } else {
          // Fallback to Firebase data if profile doesn't exist yet
          _nameController.text = user.displayName ?? '';
          _emailController.text = user.email ?? '';
          _initialName = _nameController.text;
          _initialBio = '';
        }
      }
    } catch (e) {
      debugPrint('Error loading profile: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load profile: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title: const Text('Choose from Gallery',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const Text('Take Photo',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveChanges() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);
    try {
      final profileService = ProfileService(Supabase.instance.client);
      String? uploadedUrl;

      // 1. Upload Image (if changed)
      if (_imageFile != null) {
        debugPrint('Uploading new avatar...');
        uploadedUrl = await profileService.uploadAvatar(_imageFile!, user.uid);
        debugPrint('Avatar uploaded: $uploadedUrl');
      }

      // 2. Check for Text Changes
      final currentName = _nameController.text.trim();
      final currentBio = _bioController.text.trim();

      String? nameToSend;
      String? bioToSend;

      if (currentName != _initialName) {
        nameToSend = currentName;
      }

      if (currentBio != _initialBio) {
        bioToSend = currentBio;
      }

      // 3. Update if anything changed
      if (uploadedUrl != null || nameToSend != null || bioToSend != null) {
        await profileService.updateProfile(
          userId: user.uid,
          fullName: nameToSend,
          bio: bioToSend,
          avatarUrl: uploadedUrl,
        );
      } else {
        debugPrint("No changes detected.");
      }

      if (mounted) {
        // Invalidate the profile provider so other screens (like Home) update
        ref.invalidate(userProfileProvider);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar Section
            Center(
              child: GestureDetector(
                onTap: _showImagePickerOptions,
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white.withOpacity(0.1), width: 2),
                        image: DecorationImage(
                          image: _imageFile != null
                              ? FileImage(_imageFile!) as ImageProvider
                              : NetworkImage(
                                  _currentAvatarUrl ??
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDBBAnWS59jUq6K0aHWcx6o0E9fBtWrJgKcH8ev2pUQiZtldm9WqFkLKIDcmfrIXnsnGtS1hnA2MGDa5nEPM-lBVoV5qIBsveCNT-caZSc3e5vHNPXOJESP6Osj6GkObFY405_7Uevh00kAlREqoTqYNS_IOQF0wO_0spho5Nkgpp2wgm4SAyuASIU4xhfJd3vwI4QIkZj0oqABUPTu-vhSY9yYH59L6hIAMoxvYWWs-fttdcpK-Jiv_2HmyrneVemzbG2XJsSjQlA',
                                ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Form Fields
            _buildLabel('Full Name'),
            const SizedBox(height: 8),
            _buildTextField(
                controller: _nameController, hint: 'Enter full name'),

            const SizedBox(height: 20),
            _buildLabel('Email Address'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              hint: 'Email',
              readOnly: true,
              enabled: false,
            ),

            const SizedBox(height: 20),
            _buildLabel('Bio'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _bioController,
              hint: 'Write something about yourself...',
              maxLines: 4,
            ),

            const SizedBox(height: 40),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
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
                    : const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool readOnly = false,
    bool enabled = true,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    // Colors based on RegisterPage analysis
    const surfaceColor = Color(0xFF1c1f27);
    const borderColor = Color(0xFF3b4354);

    return Container(
      decoration: BoxDecoration(
        color: readOnly ? surfaceColor.withOpacity(0.5) : surfaceColor,
        border: Border.all(
          color: readOnly ? borderColor.withOpacity(0.5) : borderColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        enabled: enabled,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(
          color: readOnly ? Colors.white.withOpacity(0.5) : Colors.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF64748b)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
