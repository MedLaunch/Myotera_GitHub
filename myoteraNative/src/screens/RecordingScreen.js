import React from 'react';
import { StyleSheet, Text, SafeAreaView, View, Pressable } from 'react-native';

export default function RecordingScreen({navigation}) {
    return (
        <SafeAreaView style={styles.container}>
            <Pressable
                onPress={()=>navigation.navigate("Home")}
                style={styles.backButton}>
                <Text style={styles.backButtonText}>Back</Text>
            </Pressable>

            <Text style={styles.recordingText}>
                Recording...
            </Text>

            <View style={styles.ellipse7}></View>
            <View style={styles.ellipse8}></View>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#1f1b27'
    },
    recordingText: {
        position: "absolute",
        width: 320,
        height: 41,
        left: 27,
        top: 118,
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: 28,
        lineHeight: 32,
        textAlign: "center",
        color: "#FFFFFF"
    },
    backButton: {
        left: 20,
        top: 10,
    },
    backButtonText: {
        color: "#FFFFFF",
        fontWeight: "bold",
    },
    ellipse7: {
        position: "absolute",
        width: 56,
        height: 56,
        left: 158.5,
        top: 700,
        backgroundColor: "#9394FC",
        shadowOffset: {
            width: 0,
            height: 4
        },
        shadowRadius: 10,
        shadowColor: "rgb(147, 148, 252)",
        shadowOpacity: 0.4,
        borderRadius: 28
    },
    ellipse8: {
        position: "absolute",
        width: 46,
        height: 46,
        left: 164,
        top: 705,
        backgroundColor: "#8A1B1B",
        borderRadius: 23
    }
      
});