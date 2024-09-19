# Golden Sample iOS App

## Overview
The golden sample is a public repository that contains samples, examples and best practices. This repository should be used internally and externally to show the Backbase approach, architecture and way of working to our developers and customers.

## Running and building

### Get started
1. [rbenv](https://github.com/rbenv/rbenv)
Use rbenv to pick a Ruby version for you application and guarantee that your development environment matches production. This enables painless Ruby upgrades and bulletproof deployments
```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# for bash_profile
echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bash_profile
# for Zsh
echo 'eval "$(~/.rbenv/bin/rbenv init - zsh)"' >> ~/.zshrc
```

2. [Bundler](https://bundler.io/)
Bundler provides a consintent environment for Ruby projects by tracking and installing the exact gems and versions that are needed.
Bundler is an exit from dependency hell, and ensures that the the gems you need are present in development, staging, and production. Starting work on a project is as simple as 
```bash
bundle install
```
3. Artifactory credentials
repo-art uses authentication as specified in your standard [netrc](https://www.gnu.org/software/inetutils/manual/html_node/The-_002enetrc-file.html) file. 
Open `~/.netrc` on your computer. If this file does not exist, create it.
 ```bash
machine repo.backbase.com
    login {username}
    password {password}
``` 

### Setup
- Install required environment tools
```bash
bundle install
```

- Setup Xcode project.
```bash
bundle exec fastlane setup

## Usage and login

The Golden Sample App is configured to use the API Sandbox environment out of the box. To be able to connect to this environment you need a Sandbox API key which can be obtained from the API Sandbox team and needs to be added to config.json. To login to the app the API Sandbox [test accounts](https://backbase.io/developers/documentation/api-sandbox/retail-banking-usa/retail-user-credentials/) can be used.

### Test plan
The testplan is part of the project, but Xcodegen cannot add it. In order to do so:

```bash
1. Go to the Snapshot scheme
2. Click on the Edit the scheme
3. Click on the respective test plan
4. Modify the details
```

## Samples
Every sample lives on its own branch. The [CATALOG.md](CATALOG.md) file lists all the samples that the repo contains. The repository is updated with every LTS releases and these updates are tagged, you can easily compare a sample to the tag to see the code changes. 

### Contribution
If you want to create your own samples check the [CONTRIBUTING.md](CONTRIBUTING.md) for the guidelines.

## Discussion

You can discuss samples, request new examples and report problems on Github Discussions. 
