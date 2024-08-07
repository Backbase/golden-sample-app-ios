# Golden Sample iOS App

## Overview
This repository serves as a public reference point, showcasing various components, examples, and recommended practices employed within the Backbase development environment. Its intended audience encompasses both internal and external developers, offering insights into Backbase's development approach, architecture, and workflow.

## Prerequisites
Building and running this project necessitates access to artifacts hosted in designated [Backbase repository](https://repo.backbase.com). Read permissions for these repositories are required.

Furthermore, the application establishes a connection with the EBP Sandbox Environment. To facilitate this connection, an API key is necessary. Instructions for obtaining this key are provided in the documentation [mentioned here](https://backbase.io/developers/documentation/api-sandbox/retail-banking-usa/ios-guide/). Once obtained, the key should be integrated into the [config.json](./app/assets/backbase/config.json) file located within the application's assets directory.

## Running and Execution

### Get started
1. [rbenv](https://github.com/rbenv/rbenv)
Utilizing rbenv ensures that a consistent Ruby version is employed for both your development environment and production. This simplifies upgrades and streamlines deployment processes. Follow the provided steps to install and configure rbenv:
```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# for bash_profile
echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bash_profile
# for Zsh
echo 'eval "$(~/.rbenv/bin/rbenv init - zsh)"' >> ~/.zshrc
```

2. The `.ruby-version` file within the project's root directory defines the required Ruby version. Before proceeding, execute the following command to install the specified version using rbenv:
```bash
rbenv install {VERSION}
```

3. [Bundler](https://bundler.io/)
Bundler safeguards a uniform development environment for Ruby projects by managing exact gem dependencies and versions. It eliminates dependency-related issues and ensures consistency across development, staging, and production environments. To initiate dependency installation, execute: 
```bash
bundle install
```
4. Artifactory credentials
Authentication for repo-art leverages the standard `.netrc` file located on your system. If this file doesn't exist, create it following the instructions [here](https://backbase.io/developers/documentation/mobile-devkit/getting-started/set-up-ios-development/):
 ```bash
machine repo.backbase.com
    login {username}
    password {password}
``` 

### Setup
- Install necessary environment tools via:
```bash
bundle install
```

- Configure the Xcode project using:
```bash
bundle exec fastlane setup
```
- Set up CocoaPods repositories:
```bash
pod repo-art add backbase-pods3 "https://repo.backbase.com/artifactory/api/pods/ios3" &&
pod repo-art add backbase-pods-retail3 "https://repo.backbase.com/artifactory/api/pods/ios-retail3" &&
pod repo-art add backbase-pods-identity "https://repo.backbase.com/artifactory/api/pods/ios-identity" &&
pod repo-art add backbase-pods-business "https://repo.backbase.com/artifactory/api/pods/ios-business" &&
pod repo-art add backbase-pods-design "https://repo.backbase.com/artifactory/api/pods/design-ios"
```

## Usage and login
Out-of-the-box, the Golden Sample App connects to the API Sandbox environment. To establish this connection, a Sandbox API key is required. Acquisition of this key is explained in the provided API Sandbox documentation. The key should be incorporated into the config.json file. Authenticating within the app can be achieved by leveraging the API Sandbox's [test accounts](https://backbase.io/developers/documentation/api-sandbox/retail-banking-usa/retail-user-credentials/).

### Test plan
The project includes a test plan; however, Xcodegen cannot automatically include it. To integrate the test plan, follow these steps:

- Navigate to the Snapshot scheme.
- Select "Edit the scheme."
- Choose the corresponding test plan.
- Modify details as necessary.

## The Journey Architecture
Backbase Mobile leverages the Journey Architecture, a design pattern where isolated sets of screens, representing a typical user flow, are grouped into "journeys." This modular approach facilitates the construction and maintenance of mobile applications by compartmentalizing functionality.

For a deeper understanding of the Journey Architecture, please refer to the official Backbase documentation: [guide](https://backbase.io/developers/documentation/retail-banking-universal/latest/system-wide/architecture/mobile-journey-architecture-understand/)


## Samples (Sample Code Exploration)

Each sample application resides within its dedicated branch. A comprehensive inventory of available samples is maintained in the [CATALOG.md](CATALOG.md) file. The repository undergoes updates with each LTS release, each iteration accompanied by a corresponding tag. This mechanism enables developers to effortlessly compare code changes within a sample by referencing its associated tag.

### Contribution
Developers are encouraged to contribute custom samples by adhering to the guidelines outlined in the [CONTRIBUTING.md](CONTRIBUTING.md) file.  This document provides a roadmap for successful integration of your sample code

## Discussion (Collaborative Discussions)

The Github Discussions forum serves as a platform for sample-related discourse. Users may engage in discussions, request new sample applications, and report any encountered issues.
