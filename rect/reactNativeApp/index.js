import { AppRegistry } from 'react-native';
import App from './App';
import NavigatorIndex from './NavigationIndex';
import { StackNavigator } from 'react-navigation';
import ActionIndex from './ActionIndex';
const AppNavigation = StackNavigator ({
    NatigationHome:{screen:NavigatorIndex},
    Home:{screen:App},
    Action:{screen:ActionIndex}
});

AppRegistry.registerComponent('reactNativeApp', () => AppNavigation);
