# Security Policy

## Supported Versions

We release patches for security vulnerabilities. Which versions are eligible for receiving such patches depends on the CVSS v3.0 Rating:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability within Restaurant Finder, please send an email to muhamadirwan1999@gmail.com. All security vulnerabilities will be promptly addressed.

Please include the following information in your report:

- Description of the vulnerability
- Steps to reproduce the issue
- Possible impact of the vulnerability
- Any suggested fixes or mitigations

## Security Measures

Restaurant Finder implements several security measures:

### Authentication & Authorization

- Firebase Authentication for secure user management
- OAuth 2.0 for Google Sign-In
- Secure token storage and session management
- Input validation and sanitization

### Data Protection

- HTTPS for all API communications
- Local data encryption using Hive
- No sensitive data stored in plain text
- Regular security dependency updates

### API Security

- API key protection through environment variables
- Rate limiting for API requests
- Input validation on all endpoints
- Error handling that doesn't expose sensitive information

## Best Practices

When contributing to this project, please follow these security best practices:

1. **Never commit sensitive information** like API keys, passwords, or personal data
2. **Use environment variables** for configuration and secrets
3. **Validate all user inputs** to prevent injection attacks
4. **Keep dependencies updated** to patch known vulnerabilities
5. **Follow the principle of least privilege** when implementing features

## Security Updates

Security updates will be released as patch versions and will be communicated through:

- GitHub Security Advisories
- Release notes
- Email notifications to maintainers

## Contact

For security-related questions or concerns, please contact:

- Email: muhamadirwan1999@gmail.com
- GitHub: [@muhamadirwan99](https://github.com/muhamadirwan99)
