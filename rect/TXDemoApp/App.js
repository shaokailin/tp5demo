import React, {Component} from 'react';
import {
    View,
    Image,
    YellowBox
} from 'react-native';

import {StackNavigator,TabNavigator,TabBarBottom} from 'react-navigation';
import cal_Home from './calculate/Home';
import for_Home from './fortune/Home';
import news_Home from './news/Home';

YellowBox.ignoreWarnings(['Warning: isMounted(...) is deprecated', 'Module RCTImageLoader']);

type Props = {};
export default class App extends Component<Props> {

    render(){
        return (
            <Tab />
        );
    }
}

const Cal_navigation = StackNavigator({
    Cal_Home:{
        screen:cal_Home,
        navigationOptions:{
            title:'测算',
        }
    }
});
const For_navigation = StackNavigator({
    For_Home:{
        screen:for_Home,
        navigationOptions:{
            title:'运势',

        }
    }
});

const News_navigation = StackNavigator({
    News_Home:{
        screen:news_Home,
        navigationOptions:{
            title:'资讯',
        }
    }
});
const TabTouteConfigs = {
    Calculate:{
        screen:Cal_navigation,
        navigationOptions:({navigation})=> ({
            tabBarLabel:'测算',
            tabBarIcon:({tintColor,focused}) => (
                focused?<Image source={require('./imgs/tabbars0.png')}/>:<Image source={require('./imgs/tabbarn0.png')}/>
            ),
        }),
    },
    Forturn:{
        screen:for_Home,
        navigationOptions:({navigation,screenProps}) => ({
            tabBarLabel:'运势',
            tabBarIcon:({tintColor,focused}) => (
                focused?<Image  source={require('./imgs/tabbars1.png')}/>:<Image  source={require('./imgs/tabbarn1.png')}/>
            ),
        }),
    },
    News:{
        screen:news_Home,
        navigationOptions:({navigation}) => ({
            tabBarLabel:'资讯',
            tabBarIcon:({tintColor,focused}) => (
                focused? <Image  source={require('./imgs/tabbars2.png')}/>:<Image  source={require('./imgs/tabbarn2.png')}/>
            ),
        }),
    }
}



const Tab = TabNavigator(
    TabTouteConfigs,
    {
        tabBarPosition:'bottom',
        tabBarComponent:TabBarBottom,
        lazy:true,
        initialRouteName:'Calculate',
        tabBarOptions:{
            showIcon:true,
            pressOpacity:0.8,
            style:{
                height:49,
                backgroundColor:'#ffffff',
                zIndex:0,
                position:'relative'
            },
            labelStype:{
                fontSize:11,
                paddingVertical:0,
                marginTop:-5
            },
            iconStyle:{
              marginTop:-5
            },
            tabStyle:{
                backgroundColor:'rgb(255,255,255)',
            },
            indicatorStyle:{
                height:0
            }
        },
        animationEnable:true,


    });