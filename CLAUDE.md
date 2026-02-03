# Claude GitHub Actions Directives

This file contains specific directives for Claude when operating in GitHub Actions workflows.

## Code Review Guidelines

### 1. Comment Format
- **DO NOT** post formal GitHub reviews (approve/request changes/comment review types)
- **DO** post individual comments directly on pull requests
- Use regular PR comments instead of review comments when providing feedback

### 2. Communication Style
- Keep comments constructive and focused on code quality
- Provide specific suggestions with code examples when possible
- Avoid duplicating comments on similar issues across files

### 3. Focus Areas
- Security best practices
- Terraform module standards and conventions
- Resource naming and tagging consistency
- Documentation completeness
- Variable validation and type constraints

### 4. Scope Limitations
- Only comment on files that have been modified in the pull request
- Avoid commenting on formatting issues that can be handled by automated tools
- Focus on meaningful architectural or logic improvements

## Workflow Behavior

### Issue Handling
- Respond to @claude mentions in issues with helpful analysis
- Provide actionable recommendations for reported problems
- Link to relevant documentation when applicable

### Pull Request Processing
- Analyze changes for potential improvements
- Comment on individual lines or files where specific feedback applies
- Summarize overall assessment in a single PR-level comment when appropriate

## Module-Specific Guidelines

### Terraform Module Expectations
- This is a reusable Terraform module - it does not specify default values for critical configuration like account IDs
- **account_ids variable**: Defaults to `[]` intentionally - the calling template MUST specify which accounts to enable Inspector for
- **Prevent misconfigurations**: When reviewing, ensure calling templates properly specify required variables like account_ids
- **Module responsibility**: The module provides the infrastructure pattern; the implementation specifies the actual configuration

### Common Review Points
- Verify calling templates specify `account_ids` explicitly (empty default is intentional for modules)
- Check that resource types are appropriate for the use case
- Ensure admin vs member account configurations are correctly set
- Validate that organization settings are only used by designated admin accounts
