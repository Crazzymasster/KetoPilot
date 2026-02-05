import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/user_provider.dart';
import '../../../../core/services/email_service.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _verificationCodeController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _awaitingVerification = false;
  final EmailService _emailService = EmailService();

  //checks if the email format looks valid
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  //checks if password meets requirements (5+ chars, 1 capital, 1 number)
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (!_isLogin) {
      if (value.length < 5) {
        return 'Password must be at least 5 characters';
      }
      if (!value.contains(RegExp(r'[A-Z]'))) {
        return 'Password must contain at least one capital letter';
      }
      if (!value.contains(RegExp(r'[0-9]'))) {
        return 'Password must contain at least one number';
      }
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _verificationCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final userNotifier = ref.read(userProvider.notifier);

      if (_isLogin) {
        //login returns null if successful, error message if not
        final errorMessage = await userNotifier.login(
          _emailController.text.trim(),
          _passwordController.text,
        );
        
        if (mounted) {
          if (errorMessage == null) {
            //success - navigate to dashboard
            context.router.replaceNamed('/dashboard');
          } else {
            //show specific error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
              ),
            );
          }
        }
      } else {
        //for signup, check if email exists first
        final userNotifier = ref.read(userProvider.notifier);
        final emailExists = await ref.read(userProvider.notifier).emailExists(
          _emailController.text.trim(),
        );

        if (emailExists) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email already registered. Please login.'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        //store pending signup data temporarily
        _emailService.storePendingSignup(
          _emailController.text.trim(),
          _passwordController.text,
          _fullNameController.text.trim().isEmpty
              ? null
              : _fullNameController.text.trim(),
        );

        //send verification email
        final emailError = await _emailService.sendVerificationEmail(
          _emailController.text.trim(),
        );
        
        if (mounted) {
          if (emailError == null) {
            //success
            setState(() {
              _awaitingVerification = true;
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Verification code sent to ${_emailController.text.trim()}',
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 5),
              ),
            );
          } else {
            //error (including rate limiting)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(emailError),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted && !_awaitingVerification) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _verifyAndRegister() async {
    final code = _verificationCodeController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the verification code'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final email = _emailController.text.trim();
      final isValid = _emailService.verifyCode(email, code);

      if (isValid) {
        //get pending signup data
        final pendingSignup = _emailService.getPendingSignup(email);
        
        if (pendingSignup == null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Signup session expired. Please try again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        //code verified, now create the account (email is already verified)
        final userNotifier = ref.read(userProvider.notifier);
        final success = await userNotifier.register(
          email: pendingSignup.email,
          password: pendingSignup.password,
          fullName: pendingSignup.fullName,
        );

        //clean up pending signup data
        _emailService.removePendingSignup(email);

        if (mounted) {
          if (success) {
            context.router.replaceNamed('/dashboard');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email already exists'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid or expired verification code'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _resendCode() async {
    final emailError = await _emailService.resendVerificationCode(
      _emailController.text.trim(),
    );
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            emailError ?? 'Verification code resent!',
          ),
          backgroundColor: emailError == null ? Colors.green : Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding * 2),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //app logo/title
                    Icon(
                      Icons.restaurant_menu,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'KetoPilot',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isLogin ? 'Welcome back!' : 'Create your account',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 48),

                    //full name (only for signup)
                    if (!_isLogin) ...[
                      TextFormField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name (Optional)',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                    ],

                    //email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      enabled: !_awaitingVerification,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!_isValidEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    //password
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      enabled: !_awaitingVerification,
                      onFieldSubmitted: (_) => _handleSubmit(),
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 8),

                    //password requirements hint (only for signup)
                    if (!_isLogin && !_awaitingVerification)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '• At least 5 characters\n• One capital letter\n• One number',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),

                    //verification code field (only shown during verification)
                    if (_awaitingVerification) ...[
                      TextFormField(
                        controller: _verificationCodeController,
                        decoration: const InputDecoration(
                          labelText: 'Verification Code',
                          prefixIcon: Icon(Icons.pin),
                          border: OutlineInputBorder(),
                          helperText: 'Enter the 6-digit code sent to your email',
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _verifyAndRegister(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: _resendCode,
                            child: const Text('Resend Code'),
                          ),
                        ],
                      ),
                    ],

                    //submit button
                    FilledButton(
                      onPressed: _isLoading
                          ? null
                          : (_awaitingVerification ? _verifyAndRegister : _handleSubmit),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              _awaitingVerification
                                  ? 'Verify & Sign Up'
                                  : (_isLogin ? 'Login' : 'Send Verification Code'),
                              style: const TextStyle(fontSize: 16),
                            ),
                    ),
                    const SizedBox(height: 16),

                    //toggle login/signup or cancel verification
                    TextButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              setState(() {
                                if (_awaitingVerification) {
                                  _awaitingVerification = false;
                                  _verificationCodeController.clear();
                                } else {
                                  _isLogin = !_isLogin;
                                  _formKey.currentState?.reset();
                                }
                              });
                            },
                      child: Text(
                        _awaitingVerification
                            ? 'Cancel'
                            : (_isLogin
                                ? 'Don\'t have an account? Sign Up'
                                : 'Already have an account? Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
