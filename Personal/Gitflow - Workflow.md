# Gitflow

Gitflow is a branching model for Git, created by Vincent Driessen. It has attracted a lot of attention because it is very well suited to collaboration and scaling the development team.

## Gitflow Workflow

The Gitflow Workflow defines a strict branching model designed around the project release. This provides a robust framework for managing larger projects.

### Branches

The central repo holds two main branches with an infinite lifetime:

- master: the branch holding the production-ready source code
- develop: the branch holding the latest development changes

> When the source code in the develop branch reaches a stable point and is ready to be released, all of the changes should be merged back into master somehow and then tagged with a release number. How this is done in detail will be discussed further on.

- feature: feature branches are used to develop new features for the upcoming or a distant future release. When starting development of a feature, the target release in which this feature will be incorporated may well be unknown at that point. The essence of a feature branch is that it exists as long as the feature is in development, but will eventually be merged back into develop (to definitely add the new feature to the upcoming release) or discarded (in case of a disappointing experiment).

- release: release branches support preparation of a new production release. They allow for last-minute dotting of i’s and crossing t’s. Furthermore, they allow for minor bug fixes and preparing meta-data for a release (version number, build dates, etc.). By doing all of this work on a release branch, the develop branch is cleared to receive features for the next big release.

- hotfix: hotfix branches are very much like release branches in that they are also meant to prepare for a new production release, albeit unplanned. They arise from the necessity to act immediately upon an undesired state of a live production version. When a critical bug in a production version must be resolved immediately, a hotfix branch may be branched off from the corresponding tag on the master branch that marks the production version.

### Commits

Every commit made uses a prefix term to indicate the purpose of the commit. This is a good practice to follow as it allows for easy filtering of commits when looking through the history.

- feat: a new feature
- fix: a bug fix
- docs: changes to documentation
- style: formatting, missing semi colons, etc; no code change
- refactor: refactoring production code
- test: adding tests, refactoring test; no production code change
- chore: updating build tasks, package manager configs, etc; no production code change
- perf: a code change that improves performance
- revert: reverting a previous commit
- merge: merging branches
- ci: changes to CI configuration files and scripts
- build: changes to build process
- temp: temporary commit that won't be included in your CHANGELOG
- wip: work in progress commit that will be included in your CHANGELOG
- release: version bump commit that will be included in your CHANGELOG
- workflow: changes to workflow files and scripts
- deps: bumping dependencies
- config: changes to configuration files
- breaking: introducing breaking changes