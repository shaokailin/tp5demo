import React, {Component} from 'react';
import {
    View,
    StyleSheet,
    Text,
    Image,
    Dimensions,
    TouchableOpacity
} from 'react-native'
const deviceWidth = Dimensions.get('window').width;
export default class TodayBest extends Component {
    render(){
      return (
          <View style={styles.container}>
            <Image style={styles.imageIconStyle} source={require('../../../imgs/todaynotice.png')}/>
              <View style={styles.lineStyle}></View>
              <View style={{flexDirection:'column',}}>
                  <View style={styles.iconViewStyle_new}>
                      <Text style={styles.iconTextStyle} >最新</Text>
                      <TouchableOpacity onPress={this.showDetailMessage.bind(this,0)}>
                          <Text  numberOfLines={1} ellipsizeMode={'tail'} style={styles.textStyle}>{this.props.data !== null && this.props.data.length > 0?this.props.data[0]:''}
                          </Text>
                      </TouchableOpacity>
                  </View>
                  <View style={styles.iconViewStyle_hot}><Text style={styles.iconTextStyle}  >热门</Text>
                      <TouchableOpacity onPress={this.showDetailMessage.bind(this,1)}>
                          <Text  numberOfLines={1} ellipsizeMode={'tail'} style={styles.textStyle}>{this.props.data !== null && this.props.data.length > 0?this.props.data[0]:''}
                          </Text>
                      </TouchableOpacity>
                  </View>
              </View>
          </View>
      );
    };
    showDetailMessage(index){
        if(this.props.eventClick){
            this.props.eventClick(index);
        }
    }
}
const styles = StyleSheet.create({
    container:{
        flex:0,
        flexDirection:'row',
        height:86,
        backgroundColor:'white',
        marginTop:1,

    },
    imageIconStyle:{
        marginLeft:35,
        width:60,
        height:57,
        marginTop:10,
    },
    lineStyle:{
        width:1,
        height:50,
        marginLeft:17,
        alignSelf:'center',
        backgroundColor:'#ededed',
    },
    iconViewStyle_hot:{
        flexDirection:'row',
        marginLeft:15,
        marginTop:10,
        paddingRight:10
    },
    iconViewStyle_new:{
        flexDirection:'row',
        marginLeft:15,
        marginTop:17,
        paddingRight:10,

    },
    iconTextStyle:{
        borderWidth:1,
        fontSize:12,
        width:30,
        textAlign:'center',
        paddingVertical:2.5,
        paddingHorizontal:1,
        borderColor:'#944643',
        color:'#944643',
    },

    textStyle:{
        width:deviceWidth - 30  - 10 - 15 - 1 - 17 - 60 - 35,
        marginLeft:5,
        marginTop:2.5
    }
});