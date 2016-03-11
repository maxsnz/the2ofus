import { combineReducers } from 'redux';
import photos from './photos';
import authorization from './authorization';

const rootReducer = combineReducers({
  photos, authorization
})

export default rootReducer