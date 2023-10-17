# Golden Sample iOS App


## Overview
This sample provides examples of the code structure, configuration, and best practices for building iOS application on the Backbase platform.

## Get started
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

## Setup
- Install required environment tools
```bash
bundle install
```

- Setup Xcode project.
```bash
bundle exec fastlane setup
```