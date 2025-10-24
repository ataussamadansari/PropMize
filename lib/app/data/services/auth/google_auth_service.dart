import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

import '../../repositories/auth/auth_repository.dart';

class GoogleAuthService extends GetxService
{
    final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
    final AuthRepository _authRepo = AuthRepository();

    final RxBool isLoading = false.obs;
    final RxBool isInitialized = false.obs;

    @override
    void onInit() 
    {
        super.onInit();
        _initializeGoogleSignIn();
    }

    // ✅ V7.0 REQUIREMENT: Initialize karo
    Future<void> _initializeGoogleSignIn() async
    {
        try
        {
            await _googleSignIn.initialize(
                clientId: "639312196993-j0ctqbi6g6d2k16c6h14up5uttq8ufaj.apps.googleusercontent.com",
                serverClientId: "639312196993-c4kc9aataiq1pnma67rdjmcvbo1bvu7e.apps.googleusercontent.com"
            );
            isInitialized.value = true;
            print('✅ Google Sign-In initialized');
        }
        catch (e)
        {
            print('❌ Google Sign-In initialization failed: $e');
        }
    }

    // ✅ V7.0: authenticate() use karo signIn() ke jagah
    Future<Map<String, dynamic>> signInWithGoogle() async
    {
        try
        {
            if (!isInitialized.value) 
            {
                await _initializeGoogleSignIn();
            }

            isLoading.value = true;

            // ✅ NEW: authenticate() call karo
            final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

            // ✅ UPDATED: authentication ab synchronous hai
            final GoogleSignInAuthentication googleAuth = googleUser.authentication;

            print('✅ Google Sign-In Successful');
            print('📧 Email: ${googleUser.email}');
            print('👤 Name: ${googleUser.displayName}');

            // Backend ko token bhejo
            final response = await _authRepo.googleLogin(
                accessToken: googleAuth.idToken!
            );

            if (response.success) 
            {
                isLoading.value = false;

                debugPrint("✅ Google Login Successful");
                debugPrint("success");
                debugPrint("user: ${response.data!.data.user}");
                debugPrint("token: ${response.data!.data.tokens.accessToken}");

                return 
                {
                    'success': true,
                    'user': response.data!.data.user,
                    'token': response.data!.data.tokens.accessToken
                };
            }
            else 
            {
                isLoading.value = false;
                return 
                {
                    'success': false,
                    'message': response.message
                };
            }
        }
        on GoogleSignInException catch (e)
        {
            isLoading.value = false;
            print('❌ Google Sign-In error: ${e.code.name} - ${e.description}');
            return 
            {
                'success': false,
                'message': _getGoogleSignInErrorMessage(e)
            };
        }
        catch (e)
        {
            isLoading.value = false;
            print('❌ Unexpected Google Sign-In error: $e');
            return 
            {
                'success': false,
                'message': 'Google Sign-In failed: $e'
            };
        }
    }

    // ✅ Error messages
    String _getGoogleSignInErrorMessage(GoogleSignInException e) 
    {
        switch (e.code.name)
        {
            case 'canceled':
                return 'Sign-in was cancelled';
            case 'interrupted':
                return 'Sign-in was interrupted';
            case 'clientConfigurationError':
                return 'Configuration issue with Google Sign-In';
            case 'providerConfigurationError':
                return 'Google Sign-In is currently unavailable';
            case 'uiUnavailable':
                return 'Google Sign-In is currently unavailable';
            case 'userMismatch':
                return 'Account issue. Please sign out and try again';
            case 'unknownError':
            default:
            return 'An unexpected error occurred';
        }
    }

    // ✅ Sign out
    Future<void> signOut() async
    {
        try
        {
            await _googleSignIn.signOut();
            print('✅ Google Sign-Out successful');
        }
        catch (e)
        {
            print('❌ Google Sign-Out error: $e');
        }
    }

    // ✅ Platform support check
    bool get supportsAuthenticate => _googleSignIn.supportsAuthenticate();
}
