import React, {Component} from 'react';
import {
    View,
    StyleSheet,
    Image,
    Text,

} from 'react-native'


export default class FourItem extends Component {
    render(){
        return (
            <View style={[this.props.style,styles.container]}>
                <Image style={styles.imgStyle}/>
                <View style={styles.textViewStyle}>
                    <Text style={styles.textStyle} numberOfLines={1} ellipsizeMode={'tail'}>
                        123123132131231231313123123
                    </Text>
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container:{
        marginBottom:5,
    },
    imgStyle:{
        backgroundColor:'red',
        flex:1,
        borderRadius:4,

    },
    textViewStyle:{
        borderBottomLeftRadius:4,
        borderBottomRightRadius:4,
        alignItems:'center',
        justifyContent:'center',
        position:'absolute',
        left:0,
        bottom:0,
        height:30,
        right:0,
        backgroundColor:'rgba(0,0,0,0.3)',
    },
    textStyle:{
        paddingHorizontal:2,
        textAlign:'center',
        color:'white',
        fontSize:12,
    }
})