import React from 'react';
import { StyleSheet, Text, SafeAreaView, View, Image, Pressable } from 'react-native';

// resizeMode fixes our issue kinda: https://reactnative.dev/docs/image

export default function HomeScreen({navigation}) {
  return (
    <SafeAreaView style={styles.container}>
        <View style={styles.innerContainer}>
            {/* Header */}
            <View style={styles.header}>
                <Text style={styles.greetText}>
                    Hi Patrick!
                </Text>
                <Text style={styles.subGreetText}>
                    Looks like you're making great progress
                </Text>
                {/* Image("myoteraLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 68.0, height: 60.0)
                Text("Hi Patrick!")
                    .foregroundColor(Color("mainTextColor"))
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                <Text style={styles.subGreetText}>
                    Looks like you're making great progress
                </Text>
                    .font(.subheadline)
                    .foregroundColor(Color("secondaryTextColor"))
                    .frame(maxWidth: .infinity, alignment: .leading) */}
            </View>
            {/* Body */}
            <View style={styles.body}>
                {/* // Recent Walk
                <View style={styles.recentWalk}>
                    <View style={styles.boxHeader}>
                        <Text>
                            "Recent Walk")
                        </Text>
                    </View>
                    // Recent Walk Body
                    <View style={styles.recentWalkBody}>
                        // Arm Graphs
                        <View style={styles.armGraphs}>
                            // Left Arm
                            <View style={styles.leftArm}>
                                <Text style={styles.armText}>
                                    Left Arm
                                </Text>
                                    .foregroundColor(Color("mainTextColor"))
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                ProgressBar(progress: $leftProgressValue)
                                    .frame(width: 90.0, height: 90.0)
                            </View>
                            // Right Arm
                            <View style={styles.rightArm}>
                                <Text style={styles.armText}>
                                    Right Arm
                                </Text>
                                    .foregroundColor(Color("mainTextColor"))
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                ProgressBar(progress: $rightProgressValue)
                                    .frame(width: 90.0, height: 90.0)
                            </View>
                        </View>
                    </View>
                    // Footer
                    <View style={styles.recentWalkFooter}>
                        <Text style={styles.dateDetails}>
                            40 min on Monday 4/11, 2:15 pm
                        </Text>
                    </View>
                </View>
                // Recent Movement
                <View style={styles.recentMovement}>
                    <View style={styles.boxHeader}>
                        <Text>
                            Recent Movement
                        </Text>
                    </View>
                    // Recent Walk Body
                    <View style={styles.recentMovementBody}>
                        // Similarity
                        <Text style={styles.simText}
                            52% Similarity
                        </Text>
                    </View>
                    // Footer
                    <View style={styles.recentMovementFooter}>
                        <Text style={styles.dateSimple}>
                            Monday 2/15
                        </Text>
                        Spacer()
                    </View>
                </View> */}
            </View>
        </View>
    </SafeAreaView>

  );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#1f1b27',
        fontFamily: "Helvetica",
        fontStyle: "normal",
    },
    innerContainer: {
        flex: 1,
        padding: 20,
    },
    header: {

    },
    greetText: {
        fontWeight: "bold",
        fontSize: 28,
        lineHeight: 32,
        color: "#FFFFFF"
    },
    subGreetText: {
        fontWeight: "normal",
        fontSize: 12,
        lineHeight: 14,
        color: "#B5B3B3"
    },
    body: {
        flexDirection: "row",
        padding: 20
    },
    boxHeader: {
        fontWeight: "bold",
        fontSize: 18,
        lineHeight: 21,
        color: "#FFFFFF"
    },
    armText: {
        fontWeight: "normal",
        fontSize: 16,
        lineHeight: 18,
        color: "#FFFFFF"
    },
    leftArm: {
        flex: 1,
        alignItems: "center",
        justifyContent: "center"
    },
    rightArm: {
        flex: 1,
        alignItems: "center",
        justifyContent: "center"
    },
    dateDetails: {
        fontWeight: "normal",
        fontSize: 12,
        lineHeight: 14,
        color: "#B5B3B3"
    },
    dateSimple: {
        fontWeight: "normal",
        fontSize: 12,
        lineHeight: 14,
        color: "#B5B3B3"
    },
    armGraphs: {

    },
    recentMovementBody: {

    },
    recentMovementFooter: {

    },
    recentWalkBody: {

    },
    recentWalkFooter: {

    },
    recentMovement: {

    },
    recentWalk: {

    },


    
    /* 
        Text("See more")
            .foregroundColor(Color("appPurpleColor"))
            .font(.subheadline)
            
        Text("See more")
            .foregroundColor(Color("appPurpleColor"))
            .font(.subheadline)
            
<Text style={styles.greetText}>
Hi Patrick!
</Text>

<Image
style={styles.myoteraLogoContainer}
// source={require("../../assets/myotera_logo.png")}
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

<Pressable
onPress={()=>navigation.navigate("Connect")}
style={styles.connectSensorButton}>
<Text>Connect Sensors</Text>
</Pressable>

<Pressable
onPress={()=>navigation.navigate("Recording")}
style={styles.lavenderButton3}>
<Text style={styles.lavenderButton3Text}>+</Text>
</Pressable>

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

<View style={styles.rightOrbEmStyle}/>

<View style={styles.leftOrbCompStyle}/>

<View style={styles.leftOrbEmStyle}/>

<Text style={styles.leftPerStyle}>
__%
</Text>

<Text style={styles.rightPerStyle}>
__%
</Text>

<Text style={styles.perSimilarityStyle}>
__% Similarity
</Text> */

    // greetText: {
    //     position: "absolute",
    //     width: 320,
    //     height: 41,
    //     left: 27,
    //     top: 118,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "bold",
    //     fontSize: 28,
    //     lineHeight: 32,
    //     color: "#FFFFFF"
    // },
    // smallWhiteWalk: {
    //     position: "absolute",
    //     width: 326,
    //     height: 38,
    //     left: 27,
    //     top: 210,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "bold",
    //     fontSize: 18,
    //     lineHeight: 21,
    //     color: "#FFFFFF"
    // },
    // smallWhiteMovement: {
    //     position: "absolute",
    //     width: 326,
    //     height: 38,
    //     left: 27,
    //     top: 499,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "bold",
    //     fontSize: 18,
    //     lineHeight: 21,
    //     color: "#FFFFFF"
    // },
    // lavenderButton1: {
    //     position: "absolute",
    //     width: 27.4,
    //     height: 0,
    //     left: 167.5,
    //     top: 700,
    //     borderWidth: 3,
    //     borderStyle: "solid",
    //     borderColor: "#FFFFFF",
    //     transform: [{rotate: "180deg"}]
    // },
    // lavenderButton2: {
    //     position: "absolute",
    //     width: 27.4,
    //     height: 0,
    //     left: 167.5,
    //     top: 700,
    //     borderWidth: 3,
    //     borderStyle: "solid",
    //     borderColor: "#FFFFFF",
    //     transform: [{rotate: "90deg"}]
    // },
    // lavenderButton3: {
    //     position: "absolute",
    //     width: 56,
    //     height: 56,
    //     left: 154,
    //     top: 675,
    //     textAlign: "center",
    //     backgroundColor: "#9394FC",
    //     borderRadius: 28,
    //     shadowOffset: {
    //         width: 0,
    //         height: 4
    //     },
    //     shadowRadius: 10,
    //     shadowColor: "rgb(147, 148, 252)",
    //     shadowOpacity: 0.4
    // },
    // lavenderButton3Text: {
    //     height: "100%",
    //     color: "white",
    //     fontSize: 32, // equivalent to 2rem
    //     lineHeight: 48, // equivalent to 3rem
    // },
    // connectSensorButton: {
    //     display: "flex",
    //     alignContent: "center",
    //     justifyContent: "center",
    //     position: "absolute",
    //     width: "auto",
    //     padding: 10,
    //     borderRadius: 5,
    //     height: 27.4,
    //     left: 200,
    //     top: 30,
    //     textAlignVertical: "center",
    //     backgroundColor: "#9394FC"
    // },
    // grayText: {
    //     position: "absolute",
    //     width: 326,
    //     height: 25,
    //     left: 27,
    //     top: 157,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "normal",
    //     fontSize: 12,
    //     lineHeight: 14,
    //     color: "#B5B3B3"
    // },
    // myoteraLogoContainer: {
    //     position: "absolute",
    //     width: 88,
    //     height: 80,
    //     left: 17,
    //     top: 39,
    // },
    // topBoxStyle: {
    //     position: "absolute",
    //     width: 326,
    //     height: 221,
    //     left: 27,
    //     top: 248,
    //     // TODO: TEST THIS
    //     //width: windowWidth*0.8693,
    //     //height: windowHeight*0.27217,
    //     //left: windowWidth*0.072,
    //     //top: windowHeight*0.3054,
    //     backgroundColor: "#262648",
    //     borderWidth: 1,
    //     borderStyle: "solid",
    //     borderColor: "#9394FC",
    //     shadowOffset: {
    //         width: 0,
    //         height: 3
    //     },
    //     shadowRadius: 20,
    //     shadowColor: "rgb(0, 0, 0)",
    //     shadowOpacity: 0.65,
    //     borderRadius: 10
    // },
    // bottomBoxStyle: {
    //     position: "absolute",
    //     width: 326,
    //     height: 128,
    //     left: 27,
    //     top: 537,
    //     backgroundColor: "#262648",
    //     borderWidth: 1,
    //     borderStyle: "solid",
    //     borderColor: "#9394FC",
    //     shadowOffset: {
    //         width: 0,
    //         height: 3
    //     },
    //     shadowRadius: 20,
    //     shadowColor: "rgb(0, 0, 0)",
    //     shadowOpacity: 0.65,
    //     borderRadius: 10
    // },
    // leftArmStyle: {
    //     position: "absolute",
    //     width: 94,
    //     height: 27,
    //     left: 51,
    //     top: 272,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "normal",
    //     fontSize: 16,
    //     lineHeight: 18,
    //     textAlign: "center",
    //     color: "#FFFFFF"
    // },
    // rightArmStyle: {
    //     position: "absolute",
    //     width: 94,
    //     height: 27,
    //     left: 223,
    //     top: 273,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "normal",
    //     fontSize: 16,
    //     lineHeight: 18,
    //     textAlign: "center",
    //     color: "#FFFFFF"
    // },
    // seeMoreTop: {
    //     position: "absolute",
    //     width: 94,
    //     height: 27,
    //     left: 247,
    //     top: 436,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "bold",
    //     fontSize: 16,
    //     lineHeight: 18,
    //     textAlign: "center",
    //     color: "#9394FC"
    // },
    // seeMoreBottom: {
    //     position: "absolute",
    //     width: 94,
    //     height: 27,
    //     left: 247,
    //     top: 635,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "bold",
    //     fontSize: 16,
    //     lineHeight: 18,
    //     textAlign: "center",
    //     color: "#9394FC"
    // },
    // dateStyle: {
    //     position: "absolute",
    //     width: 206,
    //     height: 25,
    //     left: 40,
    //     top: 637,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "normal",
    //     fontSize: 12,
    //     lineHeight: 14,
    //     color: "#B5B3B3"
    // },
    // dateNTimeStyle: {
    //     position: "absolute",
    //     width: 206,
    //     height: 25,
    //     left: 41,
    //     top: 438,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "normal",
    //     fontSize: 12,
    //     lineHeight: 14,
    //     color: "#B5B3B3"
    // },
    // leftOrbCompStyle: {
    //     position: "absolute",
    //     width: 90,
    //     height: 90,
    //     left: 57,
    //     top: 307,
    //     borderWidth: 3,
    //     borderStyle: "solid",
    //     borderColor: "#9394FC",
    //     borderRadius: 45
    // },
    // eftOrbEmStyle: {
    //     position: "absolute",
    //     width: 92,
    //     height: 92,
    //     left: 56,
    //     top: 306,
    //     borderWidth: 3,
    //     borderStyle: "solid",
    //     borderColor: "#4D4A4A",
    //     borderRadius: 46
    // },
    // leftPerStyle: {
    //     position: "absolute",
    //     width: 77,
    //     height: 29,
    //     left: 66,
    //     top: 335,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "bold",
    //     fontSize: 28,
    //     lineHeight: 32,
    //     textAlign: "center",
    //     color: "#FFFFFF"
    // },
    // rightOrbCompStyle: {
    //     position: "absolute",
    //     width: 90,
    //     height: 90,
    //     left: 226,
    //     top: 307,
    //     borderWidth: 3,
    //     borderStyle: "solid",
    //     borderColor: "#9394FC",
    //     borderRadius: 46
    // },
    // ightOrbEmStyle: {
    //     position: "absolute",
    //     width: 92,
    //     height: 92,
    //     left: 225,
    //     top: 306,
    //     borderWidth: 3,
    //     borderStyle: "solid",
    //     borderColor: "#4D4A4A",
    //     borderRadius: 46
    // },
    // rightPerStyle: {
    //     position: "absolute",
    //     width: 77,
    //     height: 29,
    //     left: 235,
    //     top: 335,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "bold",
    //     fontSize: 28,
    //     lineHeight: 32,
    //     textAlign: "center",
    //     color: "#FFFFFF"
    // },
    // perSimilarityStyle: {
    //     position: "absolute",
    //     width: 283,
    //     height: 38,
    //     left: 46,
    //     top: 573,
    //     fontFamily: "Helvetica",
    //     fontStyle: "normal",
    //     fontWeight: "bold",
    //     fontSize: 28,
    //     lineHeight: 32,
    //     textAlign: "center",
    //     color: "#FFFFFF"
    // }
});
