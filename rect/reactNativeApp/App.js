/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
    Button,
  Text,
  View,
    ActivityIndicator,
} from 'react-native';

const instructions = Platform.select({
  ios: 'linshaokai',
  android: 'kailinshao',
});

const TimerMini = require('react-timer-mixin');





type Props = {};
export default class App extends Component<Props> {
  static navigationOptions = {
    title:'kai'
  };
  render() {
      const {goBack} = this.props.navigation;
    return (
      <View style={styles.container}>
        <Text style={styles.instructions}>
            {this.props.name}
        </Text>
        <Button title='返回' onPress={()=>{
            goBack();
        }}/>
          <ActivityIndicator animating='true' size='small' color='red'/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
