import React, {Component} from 'react';
import {
    View,
    StyleSheet,
    Image,
    Text,
    TouchableOpacity,
    Dimensions
} from 'react-native'
const windownWidth = Dimensions.get('window').width;
const viewWidth = 60;
const viewBewteen = (windownWidth - viewWidth * 4 ) / 5.0;
export default class ClassifyItem extends Component {
    render(){
        return (
            <TouchableOpacity onPress={this.clickEvent.bind(this)}>
                <View style={styles.container}>
                    <Image style={styles.imageStyle}  source={{uri:this.props.url !== null?this.props.url:""}}/>
                    <Text style={styles.textStyle}>{this.props.textString}</Text>
                </View>
            </TouchableOpacity>
        );
    };
    clickEvent(){
        if(this.props.eventClick !== null){
            this.props.eventClick(this.props.flag);
        }
    }
}

const styles = StyleSheet.create({
    container:{
        flexDirection:'column',
        marginBottom:15,
        marginLeft:viewBewteen
    },
    textStyle:{
        textAlign:'center',
        fontSize:12,
        color:'#323232',
        marginTop:5
    },
    imageStyle:{
        height:60,
        width:viewWidth,
        backgroundColor:'yellow'
    }
});