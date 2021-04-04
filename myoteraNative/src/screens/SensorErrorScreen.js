import React from 'react';
import { StyleSheet, Text, SafeAreaView, View, Image } from 'react-native';

export default function SensorError() {
    return (
        <SafeAreaView style={styles.container}>
            <Text style={styles.back}>
                Back
            </Text>

            <View style={styles.vec2}></View>

            <Text style={styles.notEnoughSensors}>
                No sensor connected
            </Text>

            <Image
                style={styles.back_arrow}
            // source={require("../../back_arrow.PNG")}
            />

            <Image
                style={styles.triangle_error}
            // source={require("../../error_triangle.PNG")}
            />

        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#1f1b27'
    },
    back_arrow: {
        position: "absolute",
        width: 30,
        height: 60,
        top: 38,
        left: 20
    },
    triangle_error: {
        position: "absolute",
        width: 119,
        height: 119,
        top: 345,
        left: 125
    },
    back: {
        position: "absolute",
        width: 282,
        height: 41,
        left: 59,
        top: 55,
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: 18,
        lineHeight: 21,
        color: "#9394FC",
        justifyContent: 'center',
        alignItems: 'center'
    },
    vec2: {
        position: "absolute",
        width: 127,
        height: 124,
        left: 123,
        top: 344,
        backgroundColor: "#9394FC",
        borderWidth: 1,
        borderStyle: "solid",
        borderColor: "#000000",
        borderRadius: 10
    },
    notEnoughSensors: {
        position: "absolute",
        width: 320,
        height: 83,
        left: 27,
        top: 189,
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: 28,
        lineHeight: 32,
        textAlign: "center",
        color: "#FFFFFF",
        justifyContent: 'center',
        alignItems: 'center'
    }
});