import React from 'react';
import { StyleSheet, Text, View, Pressable } from 'react-native';

export default function RecordingScreen({navigation}) {
    return (
        <View style={styles.container}>
            <Text style={styles.recordingText}>
                Recording...
            </Text>

            <View style={styles.ellipse7}></View>

            <View style={styles.ellipse8}></View>

            <Pressable
                onPress={()=>navigation.navigate("Home")}
                style={styles.backButton}>
                <Text style={styles.backButtonText}>Back</Text>
            </Pressable>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#1f1b27'
    },
    recordingText: {
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
        textAlign: "center",
        color: "#FFFFFF"
    },
    backButton: {
        left: "20px",
        top: "10px",
    },
    backButtonText: {
        color: "white"
    },
    ellipse7: {
        position: "absolute",
        width: "56px",
        height: "56px",
        left: "158.5px",
        top: "700px",
        backgroundColor: "#9394FC",
        boxSizing: "border-box",
        boxShadow: "0px 4px 10px 5px rgba(147, 148, 252, 0.4)",
        borderRadius: "28px"
    },
    ellipse8: {
        position: "absolute",
        width: "46px",
        height: "46px",
        left: "164px",
        top: "705px",
        backgroundColor: "#8A1B1B",
        borderRadius: "23px"
    }
      
});