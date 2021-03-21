import React from 'react';
import { StyleSheet, Text, View, Image, Button, Alert } from 'react-native';

// resizeMode fixes our issue kinda: https://reactnative.dev/docs/image

export default function HomeScreen() {
  return (
      <View style={styles.container}>
          <Text style={styles.greetText}>
              Hi Patrick!
          </Text>

          <Image
              style={styles.myoteraLogoContainer}
              source={require("../../myotera_logo.png")}
          />

          <Text style={styles.grayText}>
              Looks like you're making great progress!
          </Text>

          <Text style={styles.smallWhiteWalk}>
              Recent Walk
          </Text>

          <Text style={styles.smallWhiteMovement}>
              Recent Movement
          </Text>

          <View style={styles.topBoxStyle}/>

          <View style={styles.bottomBoxStyle}/>

          <View style={styles.lavenderButton1}/>

          <View style={styles.lavenderButton2}/>



          
          <Button
              onPress={Alert.alert('Works')}
              style={styles.lavenderButton3}
              title = "Test"
          />



          <Text style={styles.leftArmStyle}>
              Left Arm
          </Text>

          <Text style={styles.rightArmStyle}>
              Right Arm
          </Text>

          <Text style={styles.dateStyle}>
              DayOfWeek Month/Day/Year
          </Text>

          <Text style={styles.dateNTimeStyle}>
              __ min on DayOfWeek Month/Day/Year, hour:minutes am/pm
          </Text>

          <View style={styles.rightOrbCompStyle}/>

          <View style={styles.rightOrbEmptyStyle}/>

          <View style={styles.leftOrbCompStyle}/>

          <View style={styles.leftOrbEmptyStyle}/>

          <Text style={styles.leftPerStyle}>
              __%
          </Text>

          <Text style={styles.rightPerStyle}>
              __%
          </Text>

          <Text style={styles.perSimilarityStyle}>
              __% Similarity
          </Text>

    </View>

  );
}

/*

          <Text style={styles.seeMoreTop}>
              See more
          </Text>

          <Text style={styles.seeMoreBottom}>
              See more
          </Text>

*/


const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#1f1b27'
    },
    greetText: {
        position: "absolute",
        width: "320px",
        height: "41px",
        left: "27px",
        top: "118px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: "28px",
        lineHeight: "32px",
        color: "#FFFFFF"
    },
    smallWhiteWalk: {
        position: "absolute",
        width: "326px",
        height: "38px",
        left: "27px",
        top: "210px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: "18px",
        lineHeight: "21px",
        color: "#FFFFFF"
    },
    smallWhiteMovement: {
        position: "absolute",
        width: "326px",
        height: "38px",
        left: "27px",
        top: "499px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: "18px",
        lineHeight: "21px",
        color: "#FFFFFF"
    },
    lavenderButton1: {
        position: "absolute",
        width: "27.4px",
        height: "0px",
        left: "167.5px",
        top: "700px",
        border: "3px solid #FFFFFF",
        transform: "rotate(180deg)"
    },
    lavenderButton2: {
        position: "absolute",
        width: "27.4px",
        height: "0px",
        left: "167.5px",
        top: "700px",
        border: "3px solid #FFFFFF",
        transform: "rotate(90deg)"
    },
    lavenderButton3: {
        position: "absolute",
        width: "56px",
        height: "56px",
        left: "154px",
        top: "675px",
        background: "#9394FC",
        borderRadius: "28px",
        boxShadow: "0px 4px 10px 5px rgba(147, 148, 252, 0.4)"
    },
    grayText: {
        position: "absolute",
        width: "326px",
        height: "25px",
        left: "27px",
        top: "157px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "normal",
        fontSize: "12px",
        lineHeight: "14px",
        color: "#B5B3B3"
    },
    myoteraLogoContainer: {
        position: "absolute",
        width: "88px",
        height: "80px",
        left: "17px",
        top: "39px",
    },
    topBoxStyle: {
        position: "absolute",
        width: "326px",
        height: "221px",
        left: "27px",
        top: "248px",
        background: "#262648",
        border: "1px solid #9394FC",
        boxSizing: "border-box",
        boxShadow: "0px 3px 20px 4px rgba(0, 0, 0, 0.65)",
        borderRadius: "10px"
    },
    bottomBoxStyle: {
        position: "absolute",
        width: "326px",
        height: "128px",
        left: "27px",
        top: "537px",
        background: "#262648",
        border: "1px solid #9394FC",
        boxSizing: "border-box",
        boxShadow: "0px 3px 20px 4px rgba(0, 0, 0, 0.65)",
        borderRadius: "10px"
    },
    leftArmStyle: {
        position: "absolute",
        width: "94px",
        height: "27px",
        left: "51px",
        top: "272px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "normal",
        fontSize: "16px",
        lineHeight: "18px",
        textAlign: "center",
        color: "#FFFFFF"
    },
    rightArmStyle: {
        position: "absolute",
        width: "94px",
        height: "27px",
        left: "223px",
        top: "273px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "normal",
        fontSize: "16px",
        lineHeight: "18px",
        textAlign: "center",
        color: "#FFFFFF"
    },
    seeMoreTop: {
        position: "absolute",
        width: "94px",
        height: "27px",
        left: "247px",
        top: "436px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: "16px",
        lineHeight: "18px",
        textAlign: "center",
        color: "#9394FC"
    },
    seeMoreBottom: {
        position: "absolute",
        width: "94px",
        height: "27px",
        left: "247px",
        top: "635px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: "16px",
        lineHeight: "18px",
        textAlign: "center",
        color: "#9394FC"
    },
    dateStyle: {
        position: "absolute",
        width: "206px",
        height: "25px",
        left: "40px",
        top: "637px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "normal",
        fontSize: "12px",
        lineHeight: "14px",
        color: "#B5B3B3"
    },
    dateNTimeStyle: {
        position: "absolute",
        width: "206px",
        height: "25px",
        left: "41px",
        top: "438px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "normal",
        fontSize: "12px",
        lineHeight: "14px",
        color: "#B5B3B3"
    },
    leftOrbCompStyle: {
        position: "absolute",
        width: "90px",
        height: "90px",
        left: "57px",
        top: "307px",
        border: "3px solid #9394FC",
        boxSizing: "border-box",
        borderRadius: "45px"
    },
    leftOrbEmptyStyle: {
        position: "absolute",
        width: "92px",
        height: "92px",
        left: "56px",
        top: "306px",
        border: "3px solid #4D4A4A",
        boxSizing: "border-box",
        borderRadius: "46px"
    },
    leftPerStyle: {
        position: "absolute",
        width: "77px",
        height: "29px",
        left: "66px",
        top: "335px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: "28px",
        lineHeight: "32px",
        textAlign: "center",
        color: "#FFFFFF"
    },
    rightOrbCompStyle: {
        position: "absolute",
        width: "90px",
        height: "90px",
        left: "226px",
        top: "307px",
        border: "3px solid #9394FC",
        boxSizing: "border-box",
        borderRadius: "46px"
    },
    rightOrbEmptyStyle: {
        position: "absolute",
        width: "92px",
        height: "92px",
        left: "225px",
        top: "306px",
        border: "3px solid #4D4A4A",
        boxSizing: "border-box",
        borderRadius: "46px"
    },
    rightPerStyle: {
        position: "absolute",
        width: "77px",
        height: "29px",
        left: "235px",
        top: "335px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: "28px",
        lineHeight: "32px",
        textAlign: "center",
        color: "#FFFFFF"
    },
    perSimilarityStyle: {
        position: "absolute",
        width: "283px",
        height: "38px",
        left: "46px",
        top: "573px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: "28px",
        lineHeight: "32px",
        textAlign: "center",
        color: "#FFFFFF"
    }
});
