import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import '../../../../core/auth/supabase_auth_service.dart';
import '../../../../core/constants/app_constants.dart';

@RoutePage()
class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _authService = SupabaseAuthService();
  
  bool _isLoading = false;
  bool _otpSent = false;
  bool _otpVerified = false;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding * 2),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: _buildForgotPasswordFlow(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordFlow() {
    if (!_otpSent) {
      return _buildEmailEntryForm();
    } else if (!_otpVerified) {
      return _buildOtpVerificationForm();
    } else {
      return _buildResetEmailSentView();
    }
  }

  Widget _buildEmailEntryForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.email_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 24),
        Text(
          'Forgot your password?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your email address. We will send a code to the phone number linked to your account.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 32),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _onSubmitEmail(),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: _isLoading ? null : _onSubmitEmail,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text(
                  'Send Code',
                  style: TextStyle(fontSize: 16),
                ),
        ),
      ],
    );
  }

  Future<void> _onSubmitEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !_isValidEmail(email)) {
      _showError('Please enter a valid email address');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Call Edge Function to look up phone and send SMS code
      final response = await _authService.client.functions.invoke(
        'get-phone-by-email',
        body: {'email': email},
      );

      // Parse the JSON string response
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      
      if (data['success'] == true) {
        setState(() {
          _isLoading = false;
          _otpSent = true;
        });
        _showSuccess('Code sent to your phone!');
      } else {
        setState(() => _isLoading = false);
        _showError(data['error'] ?? 'Failed to send code');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Error: ${e.toString()}');
    }
  }

  Widget _buildOtpVerificationForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.sms_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 24),
        Text(
          'Enter Verification Code',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We sent a 6-digit code to the phone number linked to your account.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 32),
        TextFormField(
          controller: _otpController,
          decoration: const InputDecoration(
            labelText: 'Verification Code',
            prefixIcon: Icon(Icons.sms),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          maxLength: 6,
          onFieldSubmitted: (_) => _onSubmitOtp(),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: _isLoading ? null : _onSubmitOtp,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text(
                  'Verify Code',
                  style: TextStyle(fontSize: 16),
                ),
        ),
      ],
    );
  }

  Future<void> _onSubmitOtp() async {
    final email = _emailController.text.trim();
    final code = _otpController.text.trim();

    if (code.isEmpty || code.length != 6) {
      _showError('Please enter the 6-digit code');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Call Edge Function to verify the code
      final verified = await _verifyCode(email, code);

      if (verified) {
        setState(() {
          _isLoading = false;
          _otpVerified = true;
        });
        _showSuccess('Code verified!');
        
        // Send password reset email
        await _sendPasswordResetEmail(email);
      } else {
        setState(() => _isLoading = false);
        _showError('Invalid or expired code');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('An error occurred. Please try again.');
    }
  }

  Future<bool> _verifyCode(String email, String code) async {
    try {
      final response = await _authService.client.functions.invoke(
        'verify-password-reset-code',
        body: {'email': email, 'code': code},
      );

      // Parse the JSON string response
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      
      if (data['success'] == true) {
        return true;
      } else {
        _showError(data['error'] ?? 'Invalid or expired code');
        return false;
      }
    } catch (e) {
      _showError('Error: ${e.toString()}');
      return false;
    }
  }

  Future<void> _sendPasswordResetEmail(String email) async {
    try {
      final result = await _authService.resetPassword(email: email);
      if (!result.success) {
        _showError('Failed to send password reset email');
      }
    } catch (e) {
      _showError('Failed to send password reset email');
    }
  }

  Widget _buildResetEmailSentView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.mark_email_read_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 24),
        Text(
          'Check Your Email',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We sent a password reset link to your email address. Please check your inbox.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: () => context.router.maybePop(),
          child: const Text('Back to Login'),
        ),
      ],
    );
  }
}
