---
name: start-pr-review
description: Fetch a GitHub PR, switch to its branch, and explain in simple language what the PR does and how to read the code. Usage - /start-pr-review <PR URL>
argument-hint: <PR URL>
disable-model-invocation: true
---

I want to review the PR at: $ARGUMENTS

Fetch the PR and switch to its branch, then help me understand:

1. What is the PR trying to do?
2. How should I read the code to understand what is happening, i.e., how is the PR trying to achieve what it says?

Explain everything in very simple language, as if I know very little about the codebase and the project.
