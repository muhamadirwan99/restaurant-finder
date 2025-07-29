import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  Widget build(context, LoginController controller) {
    controller.view = this;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 24,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height - 24,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height + 41,
              ),
              padding: const EdgeInsets.all(24.0),
              child: controller.isContentLogin
                  ? _contentLogin(context, controller)
                  : _contentSignup(context, controller),
            ),
          ),
        ),
      ),
    );
  }

  _contentLogin(BuildContext context, LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ContainerLogo(),
        const Spacer(),
        Text(
          "Sign in to your account",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 24.0,
        ),
        BaseForm(
          label: "Email Address",
          hintText: "Enter your email address",
          prefixIcon: const Icon(Icons.email_outlined),
          textInputType: TextInputType.emailAddress,
          textEditingController: controller.emailLoginC,
        ),
        const SizedBox(
          height: 16.0,
        ),
        BaseForm(
          label: "Password",
          hintText: "Enter your password",
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon:
              controller.obscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
          obsecure: controller.obscure,
          textEditingController: controller.passwordLoginC,
          onEditComplete: () {
            controller.login();
          },
          onTapSuffix: () {
            controller.obscure = !controller.obscure;
            controller.update();
          },
        ),
        const SizedBox(
          height: 24.0,
        ),
        BasePrimaryButton(
          text: "Sign In",
          borderRadius: 50,
          onPressed: () {
            controller.login();
          },
        ),
        const SizedBox(
          height: 24.0,
        ),
        Text(
          "other way to sign in",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 1.0,
            ),
          ),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.transparent,
            child: IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              onPressed: () {
                controller.loginWithGoogle();
              },
            ),
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            TextButton(
              onPressed: () {
                controller.clearTextFields();
                controller.isContentLogin = false;
                controller.update();
              },
              child: Text(
                "Create Account",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }

  _contentSignup(BuildContext context, LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ContainerLogo(),
        const Spacer(),
        Text(
          "Create new account",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 24.0,
        ),
        BaseForm(
          label: "Full Name",
          hintText: "Enter your full name",
          prefixIcon: const Icon(Icons.person_outline),
          textEditingController: controller.nameC,
        ),
        const SizedBox(
          height: 16.0,
        ),
        BaseForm(
          label: "Email Address",
          hintText: "Enter your email address",
          prefixIcon: const Icon(Icons.email_outlined),
          textInputType: TextInputType.emailAddress,
          textEditingController: controller.emailSignupC,
        ),
        const SizedBox(
          height: 16.0,
        ),
        BaseForm(
          label: "Password",
          hintText: "Enter your password",
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon:
              controller.obscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
          obsecure: controller.obscure,
          textEditingController: controller.passwordSignupC,
          onEditComplete: () {
            controller.addUser();
          },
          onTapSuffix: () {
            controller.obscure = !controller.obscure;
            controller.update();
          },
        ),
        const SizedBox(
          height: 24.0,
        ),
        BasePrimaryButton(
          text: "Sign Up",
          borderRadius: 50,
          onPressed: () {
            controller.addUser();
          },
        ),
        const SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            TextButton(
              onPressed: () {
                controller.clearTextFields();
                controller.isContentLogin = true;
                controller.update();
              },
              child: Text(
                "Back to Sign In",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
