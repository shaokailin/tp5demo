import React, {Component} from 'react';
import {
    View,
    Text,
    Button,
    Navigator,
} from 'react-native';
import HomeIndex from './HomeIndex';
export default class NavigationIndex extends Component {
    static navigationOptions = {
      title:'Hello',
    };

    push() {

    }
    render(){
        const { navigate } = this.props.navigation;
        return (
            <View>
                <Text>
                    林少凯
                </Text>
                <Button title='跳转' onPress={()=>{
                    navigate('Home',{ kai : '123' });
                }}/>
            </View>
        );
    }
}