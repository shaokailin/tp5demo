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
                <Image source={{uri:this.props.itemdata.image}} style={styles1.imgStyle}/>
                <View style={{flex:1}}>
                    <Text numberOfLines={2} ellipsizeMode={'tail'} style={styles1.titleStyle}>
                        {this.props.itemdata.title}
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
        width:87,
    },
    titleStyle:{
        color:'#323232',
        fontSize:14,
        marginTop:12.5,
        marginLeft:17.5
    }
})