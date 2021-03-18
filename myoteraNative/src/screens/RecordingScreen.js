import React from 'react';
import { StyleSheet, Text, View, Image, Button, TouchableOpacity } from 'react-native';

export default function RecordingScreen() {
    return (
        <View style={styles.container}>
            <View style={styles.recording}></View>

            <View style={styles.rect1}></View>

            <View style={styles.recordingText}></View>

            <View style={styles.ellipse7}></View>

            <View style={styles.ellipse8}></View>

        </View>
        
    );
}

const styles = StyleSheet.create({
    recording: {
        position: "relative",
        width: "375px",
        height: "812px",
        background: "#FFFFFF"
    },
    rect1: {
        position: "absolute",
        width: "375px",
        height: "812px",
        left: "0px",
        top: "0px",
        background: "#201F24"
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
    ellipse7: {
        position: "absolute",
        width: "56px",
        height: "56px",
        left: "158.5px",
        top: "700px",
        background: "#9394FC",
        boxShadow: "0px 4px 10px 5px rgba(147, 148, 252, 0.4)"
    },
    ellipse8: {
        position: "absolute",
        width: "46px",
        height: "46px",
        left: "164px",
        top: "705px",
        background: "#8A1B1B"
    }
      
});