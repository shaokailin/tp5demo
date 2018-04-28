import React, {Component} from 'react';
import {
    View,
    StyleSheet,
    Text,
    Dimensions
} from 'react-native'
import FourItem from './FourItem';
const deviceWidth = Dimensions.get('window').width;
const viewWidth = (deviceWidth - 40 - 10 - 5) / 2.0;
const viewHeight = 105 * deviceWidth / 375;

export default class FuncFour extends Component {
    render(){
        return(
            <View style={styles1.container}>
                <Text style={styles1.textStyle}>
                    {this.getTitleText(this.props.type)}
                </Text>
                <View style={styles1.contentStyle}>
                    {this.getItems()}
                </View>
            </View>
        );
    }
    getItems(){
        var items = [];
        console.log(deviceWidth + '--' + viewWidth + '---' + viewHeight)
        if(this.props.data && this.props.data.length > 0){
            for(var i = 0; i < this.props.data.length;i++) {
                items.push(
                    <FourItem key={i} style={{width:viewWidth, height:viewHeight}}/>
                );
            }
        }
        return items;
    }
    getTitleText(type){
        var titleString = '';
        switch(type){
            case 0:
                titleString = '感情婚姻';
                break;
            case 1:
                titleString = '感情婚姻1';
                break;
            case 2:
                titleString = '感情婚姻2';
                break;
            case 3:
                titleString = '感情婚姻4';
                break;
            default:
                break;
        }
        return titleString;
    }
}
const styles1 = StyleSheet.create({
    container:{
        marginHorizontal:20,
    },
    textStyle:{
        color:'#323232',
        fontSize:18,
        marginTop:15,
        marginBottom:10
    },
    contentStyle:{
        justifyContent:'space-between',
        flexDirection:'row',
        alignItems:'center',
        flexWrap:'wrap'

    }
})