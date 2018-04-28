import React,{Component} from 'react';
import {
    View,
    StyleSheet
} from 'react-native';
const dotNorColor = 'white';
const dotSelectedColor = 'blue';
export default class BannerDotView extends Component {
    render(){
        return (
            <View style={[styles.dotsView,this.props.style]}>
                {this.createDots()}
            </View>
        );
    };
    createDots(){
        var dots = [];
        for (var i = 0; i < this.props.count;i++){
            var dotBg = this.props.index == i?dotSelectedColor:dotNorColor;
            dots.push(
                <View key={i} style={[styles.dots,{backgroundColor:dotBg}]}></View>
            );
        }
        return dots;
    }
}
const styles = StyleSheet.create({
    dotsView:{
        flexDirection:'row',
        alignItems:'center',
        justifyContent:'center',
        position:'absolute',
        bottom:0,
        left:0,
        height:25,
    },
    dots:{
        width:5,
        height:5,
        borderRadius:5,
        marginLeft:8
    },
});