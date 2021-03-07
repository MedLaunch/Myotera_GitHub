# Tab navigation example

<p>
  <!-- iOS -->
  <img alt="Supports Expo iOS" longdesc="Supports Expo iOS" src="https://img.shields.io/badge/iOS-4630EB.svg?style=flat-square&logo=APPLE&labelColor=999999&logoColor=fff" />
  <!-- Android -->
  <img alt="Supports Expo Android" longdesc="Supports Expo Android" src="https://img.shields.io/badge/Android-4630EB.svg?style=flat-square&logo=ANDROID&labelColor=A4C639&logoColor=fff" />
  <!-- Web -->
  <img alt="Supports Expo Web" longdesc="Supports Expo Web" src="https://img.shields.io/badge/web-4630EB.svg?style=flat-square&logo=GOOGLE-CHROME&labelColor=4285F4&logoColor=fff" />
</p>

## 🚀 How to use

- Install with `yarn` or `npm install`.
- Run `expo start` to try it out.

## 📝 Notes

- This is a very basic example from the [react navigation](https://reactnavigation.org/) docs.
- [Tab navigation documentation](https://reactnavigation.org/docs/tab-based-navigation).


## Setup

- cd into myoteraNative folder
- install node (nodejs.org)
- install expo cli and react native
  - npm install -g expo-cli react-native
  - If you have a permissions issue: look it up on google
- start the app by running expo start or npm run web

- If you're on a mac and you want to setup the swift stuff
- react-native link
- cd into the ios folder of myoteraNative and do a pod install
  - If you run into any issues during pod installation:
    - sudo xcode-select --switch /Applications/Xcode.app/
- open xcworkspace file in ios folder

- May need to change the signing for the team in the xcode project
- Change the bundle identifier

- If you have an issue with the source and node modules
- go to myoteraNative/node_modules/react-native-mds/src/RNMds.js
- Replace `module.export = ...` with `export default NativeModules.ReactMds;`

- When trying to run the app, make sure the phone trusts the app
  - On iPhone
    - Setting -> General -> Device Management
    - Something should pop up for trusting the app, hit `trust`
