import React, {Component} from 'react';
import {
    View,
    StyleSheet,
    Text,
    Image
} from 'react-native'

export default class BannerCell extends Component {
    render(){
        return(
            <View style={styles1.container}>
                <Image style={styles1.imgStyle}/>
                <View style={{flex:1}}>
                    <Text numberOfLines={2} ellipsizeMode={'tail'} style={styles1.titleStyle}>
                        {'1231321313123123132123131lhflasdhfalsfhlashglshgljshglksfhgksdfjhgk'}
                    </Text>
                </View>
            </View>
        );
    }
}
const styles1 = StyleSheet.create({
    container:{
        backgroundColor:'white',
        height:87,
        marginHorizontal:5,
        flexDirection:'row'
    },
    imgStyle:{
        height:'100%',
        backgroundColor:'red',
        width:87,
    },
    titleStyle:{
        color:'#323232',
        fontSize:14,
        marginTop:12.5,
        marginLeft:17.5
    }
})