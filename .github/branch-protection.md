# BitNET Branch Protection Setup

This document outlines the recommended branch protection rules for the BitNET repository to ensure code quality and prevent broken code from reaching production.

## Recommended Branch Protection Rules for `main` branch:

### 1. **Require pull request reviews before merging**
- ✅ **Enabled**
- Required approving reviews: **1**
- Dismiss stale reviews when new commits are pushed: **Yes**
- Require review from code owners: **Yes** (if CODEOWNERS file exists)

### 2. **Require status checks to pass before merging**
- ✅ **Enabled**
- Require branches to be up to date before merging: **Yes**

#### Required status checks:
- ✅ `test / Run Tests and Analysis`
- ✅ `build / Build Application`  
- ✅ `security / Security Analysis`
- ⚠️ `integration-test / Integration Tests` (optional - can continue on error)

### 3. **Require conversation resolution before merging**
- ✅ **Enabled**
- All conversations must be resolved before merging

### 4. **Require signed commits**
- ⚠️ **Optional** - Enable for enhanced security

### 5. **Require linear history**
- ⚠️ **Optional** - Enable to maintain clean git history

### 6. **Restrictions**
- Include administrators: **No** (allows admins to bypass in emergencies)
- Allow force pushes: **No**
- Allow deletions: **No**

## How to Apply These Settings:

### Via GitHub Web Interface:
1. Go to your repository on GitHub
2. Click **Settings** tab
3. Click **Branches** in left sidebar
4. Click **Add rule** or edit existing rule for `main`
5. Configure the settings as outlined above

### Via GitHub CLI:
```bash
# Install GitHub CLI if not already installed
# https://cli.github.com/

# Set branch protection for main branch
gh api repos/:owner/:repo/branches/main/protection \
  --method PUT \
  --field required_status_checks='{"strict":true,"contexts":["test / Run Tests and Analysis","build / Build Application","security / Security Analysis"]}' \
  --field enforce_admins=false \
  --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
  --field restrictions=null
```

## Benefits of These Protection Rules:

### 🛡️ **Quality Assurance**
- **No broken code** reaches main branch
- **All changes reviewed** by team members
- **Automated testing** catches issues early

### 🚀 **Deployment Safety**
- **Main branch always deployable**
- **Rollback safety** with clean history
- **Confidence in releases**

### 👥 **Team Collaboration**
- **Knowledge sharing** through code reviews
- **Consistent code quality** across team
- **Documentation** of change rationale

### 🔒 **Security Benefits**
- **Prevents malicious code** injection
- **Dependency vulnerability** scanning
- **Code pattern analysis** for security issues

## Workflow After Setup:

### For Developers:
1. **Create feature branch** from `main`
2. **Make changes** and commit
3. **Run tests locally** before pushing
4. **Create pull request** to `main`
5. **Wait for CI checks** to pass
6. **Request review** from team member
7. **Address feedback** and resolve conversations
8. **Merge after approval** and passing tests

### For Reviewers:
1. **Review code changes** thoroughly
2. **Check CI status** before approving
3. **Test functionality** if needed
4. **Provide constructive feedback**
5. **Approve when satisfied** with quality

## Emergency Procedures:

### Hotfix Process:
1. **Create hotfix branch** from `main`
2. **Make minimal critical fix**
3. **Expedited review process**
4. **Emergency merge** (admin override if needed)
5. **Immediate follow-up** with proper testing

### Admin Override:
- Only for **critical production issues**
- **Document reason** for override
- **Follow up** with proper PR process
- **Review in next team meeting**

---

**Note**: These protection rules work in conjunction with the CI/CD pipeline defined in `.github/workflows/ci.yml` to create a robust development workflow that ensures code quality while maintaining development velocity.