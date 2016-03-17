import { combineReducers } from 'redux';
import gallery from './gallery';
import authorization from './authorization';

const rootReducer = combineReducers({
  gallery, authorization
})

export default rootReducer