import { AUTH } from '../actions'

const initialState = {

};

// Reducer for authorization store
export default function authorization(state = initialState, action) {
  console.log(action);
  switch (action.type) {
  case AUTH:
    return state;
  default:
    return state;
  }
}