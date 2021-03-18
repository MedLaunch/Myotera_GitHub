import React from 'react';
import { StyleSheet, Text, View, Image, Button, TouchableOpacity } from 'react-native';

export default function SensorError() {
    return (
        <View style={styles.container}>
            <View style={styles.error}></View>

            <View style={styles.rect1}></View>

            <View style={styles.group3}></View>

            <View style={styles.back}></View>

            <View style={styles.vec1}></View>

            <View style={styles.vec2}></View>

            <View style={styles.notEnoughSensors}></View>

            <View style={styles.noSensors}></View>

            <View style={styles.errorArt}></View>

        </View>
        
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#1f1b27',
        justifyContent: 'center',
        alignItems: 'center'
    },
    error: {
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
    group3: {
        position: "absolute",
        width: "307px",
        height: "42px",
        left: "34px",
        top: "54px"
    },
    back: {
        position: "absolute",
        width: "282px",
        height: "41px",
        left: "59px",
        top: "55px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: "18px",
        lineHeight: "21px",
        color: "#9394FC"
    },
    vec1: {
        position: "absolute",
        width: "12px",
        height: "22.5px",
        left: "34px",
        top: "54px",
        border: "2px solid #9394FC"
    },
    vec2: {
        position: "absolute",
        width: "127px",
        height: "124px",
        left: "123px",
        top: "344px",
        background: "#9394FC",
        border: "1px solid #000000",
        borderRadius: "10px"
    },
    notEnoughSensors: {
        position: "absolute",
        width: "320px",
        height: "83px",
        left: "27px",
        top: "189px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: "28px",
        lineHeight: "32px",
        textAlign: "center",
        color: "#FFFFFF"
    },
    noSensors: {
        position: "absolute",
        width: "320px",
        height: "83px",
        left: "28px",
        top: "539px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "normal",
        fontSize: "21px",
        lineHeight: "24px",
        textAlign: "center",
        color: "#B5B3B3"
    },
    errorArt: {
        position: "absolute",
        width: "77px",
        height: "62px",
        left: "148px",
        top: "393px",
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: "50px",
        lineHeight: "57px",
        textAlign: "center",
        color: "#FFFFFF"
    }
});