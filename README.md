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
- Setup pod repos.
```bash
pod repo-art add backbase-pods3 "https://repo.backbase.com/artifactory/api/pods/ios3" &&
pod repo-art add backbase-pods-retail3 "https://repo.backbase.com/artifactory/api/pods/ios-retail3" &&
pod repo-art add backbase-pods-identity "https://repo.backbase.com/artifactory/api/pods/ios-identity" &&
pod repo-art add backbase-pods-business "https://repo.backbase.com/artifactory/api/pods/ios-business" &&
pod repo-art add backbase-pods-design "https://repo.backbase.com/artifactory/api/pods/design-ios"
```

## Usage and login

The Golden Sample App is configured to use the API Sandbox environment out of the box. To be able to connect to this environment you need a Sandbox API key which can be obtained from the API Sandbox team and needs to be added to config.json. To login to the app the API Sandbox [test accounts](https://backbase.io/developers/documentation/api-sandbox/retail-banking-usa/retail-user-credentials/) can be used.

## Test plan
The testplan is part of the project, but Xcodegen cannot add it. In order to do so:

```bash
1. Go to the Snapshot scheme
2. Click on the Edit the scheme
3. Click on the respective test plan
4. Modify the details
```
