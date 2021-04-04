import React from 'react';
import { StyleSheet, Text, SafeAreaView, View, Image, Pressable } from 'react-native';

// resizeMode fixes our issue kinda: https://reactnative.dev/docs/image

export default function HomeScreen({navigation}) {
  return (
    <SafeAreaView style={styles.container}>
        <View style={styles.innerContainer}>
            {/* Header */}
            <View style={styles.header}>
                <View style={styles.headerGreeting}>
                    <Image 
                        style={styles.myoteraLogo}
                        source={require("./../../assets/myotera_logo.png")}
                    />
                    <Text style={styles.greetText}>
                        Hi Patrick!
                    </Text>
                    <Text style={styles.subGreetText}>
                        Looks like you're making great progress
                    </Text>
                </View>
                <Pressable
                    onPress={()=>navigation.navigate("Connect")}
                    style={styles.connectSensorButton}>
                    <Text style={styles.connectSensorText}>
                        Connect Sensors
                    </Text>
                </Pressable>
            </View>
            {/* Body */}
            <View style={styles.body}>
                {/* Recent Walk */}
                <View style={styles.recentWalk}>
                    {/* Box Header */}
                    <View style={styles.boxHeader}>
                        <Text style={styles.boxHeaderText}>
                            Recent Walk
                        </Text>
                    </View>
                    {/* Recent Walk Body */}
                    <View style={{...styles.recentBody, height: "75%"}}>
                        {/* Arm Graphs */}
                        <View style={styles.armGraphs}>
                            {/* Left Arm */}
                            <View style={styles.leftArm}>
                                <Text style={styles.armText}>
                                    Left Arm
                                </Text>
                                <View style={styles.orb}>

                                </View>
                            </View>
                            {/* Right Arm */}
                            <View style={styles.rightArm}>
                                <Text style={styles.armText}>
                                    Right Arm
                                </Text>
                                <View style={styles.orb}>

                                </View>
                            </View>
                        </View>
                        {/* Footer */}
                        <View style={styles.recentFooter}>
                            <Text style={styles.dateDetails}>
                                40 min on Monday 4/11, 2:15 pm
                            </Text>
                        </View>
                    </View>
                </View>{/* Recent Walk */}
                {/* Recent Movement */}
                <View style={styles.recentMovement}>
                    <View style={styles.boxHeader}>
                        <Text style={styles.boxHeaderText}>
                            Recent Movement
                        </Text>
                    </View>
                    {/* Recent Movement Body */}
                    <View style={{...styles.recentBody, height: "50%"}}>
                        {/* Similarity */}
                        <Text style={styles.simText}>
                            52% Similarity
                        </Text>
                        {/* Footer */}
                        <View style={styles.recentFooter}>
                            <Text style={styles.dateSimple}>
                                Monday 2/15
                            </Text>
                        </View>
                    </View>
                </View>{/* Recent Movement */}
                {/* Start Recording */}
                <View style={styles.record}>
                    <Pressable
                        onPress={()=>navigation.navigate("Recording")}
                        style={styles.recordButton}>
                        <Text style={styles.recordPlus}>+</Text>
                    </Pressable>
                </View>
            </View>{/* Body */}
        </View>{/* Inner Container */}
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
        flex: 1,
        flexDirection: "row",
    },
    headerGreeting: {
        
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
    myoteraLogo: {
        width: "35%",
        flex: 0.7,
    },
    connectSensorButton: {
        width: "auto",
        padding: 5,
        borderRadius: 5,
        height: "20%",
        textAlignVertical: "center",
        backgroundColor: "#9394FC"
    },
    connectSensorText: {
        fontWeight: "bold",
        color: "#FFFFFF",
    },
    body: {
        flex: 4,
    },
    recentWalk: {
        flex: 1.5,
    },
    recentMovement: {
        flex: 1,
    },
    record: {
        alignItems: "center"
    },
    boxHeaderText: {
        fontWeight: "bold",
        fontSize: 18,
        lineHeight: 21,
        color: "#FFFFFF",
    },
    armText: {
        fontWeight: "normal",
        fontSize: 16,
        lineHeight: 18,
        color: "#FFFFFF",
        marginBottom: 10,
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
        color: "#B5B3B3",
    },
    dateSimple: {
        fontWeight: "normal",
        fontSize: 12,
        lineHeight: 14,
        color: "#B5B3B3"
    },
    armGraphs: {
        flexDirection: "row",
        flex: 10,
    },
    recentFooter: {
        flex: 1,
    },
    boxHeader: {
        marginBottom: 15,
    },
    recentBody: {
        backgroundColor: "#262648",
        borderWidth: 1,
        borderStyle: "solid",
        borderColor: "#9394FC",
        shadowOffset: {
            width: 0,
            height: 3
        },
        shadowRadius: 20,
        shadowColor: "rgb(0, 0, 0)",
        shadowOpacity: 0.65,
        borderRadius: 10,
        padding: 20,
    },
    orb: {
        width: 92,
        height: 92,
        borderWidth: 3,
        borderStyle: "solid",
        borderColor: "#4D4A4A",
        borderRadius: 46,
    },
    simText: {
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: 28,
        lineHeight: 32,
        textAlign: "center",
        color: "#FFFFFF",
        flex: 4,
    },
    recordButton: {
        width: 56,
        height: 56,
        backgroundColor: "#9394FC",
        borderRadius: 28,
        shadowOffset: {
            width: 0,
            height: 4
        },
        shadowRadius: 10,
        shadowColor: "rgb(147, 148, 252)",
        shadowOpacity: 0.4
    },
    recordPlus: {
        textAlign: "center",
        height: "100%",
        color: "white",
        fontSize: 32, // equivalent to 2rem
        lineHeight: 48, // equivalent to 3rem
    },
});
