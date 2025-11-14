# Contributing to WehttamSnaps

Thank you for your interest in contributing to WehttamSnaps! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues

1. **Check existing issues** first to avoid duplicates
2. **Use the issue templates** when creating new issues
3. **Provide detailed information**:
   - System information (OS, hardware, etc.)
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable
   - Relevant logs

### Feature Requests

1. **Check existing issues** for similar requests
2. **Provide clear description** of the feature
3. **Explain the use case** and why it's valuable
4. **Consider implementation** if you have ideas

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Make your changes** following the guidelines below
4. **Test thoroughly** on your system
5. **Commit with clear messages**
6. **Push to your fork**: `git push origin feature/amazing-feature`
7. **Create a pull request**

## 📝 Development Guidelines

### Code Style

#### Shell Scripts
- Use 4 spaces for indentation
- Use `#!/bin/bash` shebang
- Add comments for complex logic
- Use meaningful variable names
- Handle errors appropriately

#### Configuration Files
- Keep consistent formatting
- Add comments for complex sections
- Use logical grouping
- Maintain backwards compatibility when possible

#### Documentation
- Use clear, concise language
- Include examples
- Update documentation with code changes
- Use proper markdown formatting

### Testing

- Test on fresh Arch Linux installation
- Verify all scripts work correctly
- Check for syntax errors
- Test keybinds and functionality
- Ensure no broken references

### File Structure

Follow the existing structure:
```
WehttamSnaps/
├── configs/          # Configuration files
├── packages/         # Package lists
├── themes/           # Theme files
├── docs/             # Documentation
├── assets/           # Media assets
└── scripts/          # Utility scripts
```

## 🐛 Bug Reports

When reporting bugs, please include:

### System Information
```bash
# System info
neofetch

# Package versions
pacman -Qi hyprland
pacman -Qi noctalia-shell

# Hardware info
lspci -k | grep -A 2 -i vga
```

### Logs
```bash
# Hyprland logs
cat ~/.local/share/hyprland/hyprland.log

# PipeWire logs
journalctl --user -u pipewire

# Application logs
journalctl -xe
```

### Steps to Reproduce
1. Clear, numbered steps
2. Expected behavior
3. Actual behavior
4. Screenshots if relevant

## 💡 Feature Ideas

We welcome feature suggestions, especially for:

- **Performance optimizations**
- **New webapp templates**
- **Additional themes**
- **Better documentation**
- **Quality of life improvements**
- **Hardware compatibility**
- **Gaming enhancements**

## 📋 Pull Request Process

### Before Submitting

1. **Read this document** carefully
2. **Check existing issues** and PRs
3. **Test your changes** thoroughly
4. **Update documentation** if needed
5. **Follow code style** guidelines

### PR Template

Use this structure for your PR:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How I tested my changes

## Screenshots
If applicable, add screenshots

## Additional Notes
Any additional information
```

### Review Process

1. **Automated checks** pass
2. **Code review** by maintainers
3. **Testing** on maintainer systems
4. **Documentation** review
5. **Approval** and merge

## 🏆 Recognition

Contributors are recognized in:
- README.md contributors section
- CHANGELOG.md for significant changes
- Special mention in releases
- Invitation to contributor Discord

## 📞 Getting Help

If you need help contributing:

1. **Check existing issues** for similar problems
2. **Ask questions** in existing relevant issues
3. **Join our Discord** for real-time help
4. **Email us** at crowdrocker@proton.me

## 🔒 Security

If you discover security vulnerabilities:

1. **Do NOT open public issues**
2. **Email us privately** at crowdrocker@proton.me
3. **Provide detailed information** about the vulnerability
4. **Wait for our response** before disclosing

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License, same as the project.

## 🙏 Thank You

Thank you for contributing to WehttamSnaps! Every contribution helps make this project better for everyone.

---

**Happy coding! 🚀**

Made with ❤️ by the WehttamSnaps team
