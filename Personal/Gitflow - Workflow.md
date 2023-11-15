# Gitflow

  

Gitflow is a branching model for Git, created by Vincent Driessen. It has attracted a lot of attention because it is very well suited to collaboration and scaling the development team.

  

## Gitflow Workflow

  

The Gitflow Workflow defines a strict branching model designed around the project release. This provides a robust framework for managing larger projects.

  

### Branches

  

The central repo holds two main branches with an infinite lifetime:

  

- master: the branch holding the production-ready source code

- develop: the branch holding the latest development changes

    When the source code in the develop branch reaches a stable point and is ready to be released, all of the changes should be merged back into master somehow and then tagged with a release number. How this is done in detail will be discussed further on.

- feature

- release

- hotfix

- support