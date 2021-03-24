import React, { Component } from 'react';
import { StyleSheet, Text, View, Image, Button, TouchableOpacity } from 'react-native';
import { createStackNavigator, createAppContainer } from 'react-navigation';

export default function SensorError() {
    return (
        <View style={styles.container}>
            <Text style={styles.back}>
                Back
            </Text>

            <View style={styles.vec2}></View>

            <Text style={styles.notEnoughSensors}>
                No sensor connected
            </Text>

            <Image
                style={styles.back_arrow}
                source={require("../../back_arrow.PNG")}
            />

            <Image
                style={styles.triangle_error}
                source={require("../../error_triangle.PNG")}
            />

        </View>
        
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#1f1b27'
    },
    back_arrow: {
        position: "absolute",
        width: "30px",
        height: "60px",
        top: "38px",
        left: "20px"
    },
    triangle_error: {
        position: "absolute",
        width: "119px",
        height: "119px",
        top: "345px",
        left: "125px"
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
        color: "#9394FC",
        justifyContent: 'center',
        alignItems: 'center'
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
        color: "#FFFFFF",
        justifyContent: 'center',
        alignItems: 'center'
    }
});