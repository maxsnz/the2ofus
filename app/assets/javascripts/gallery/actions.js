import fetch from 'isomorphic-fetch';

export const FETCH_ALL_ITEMS = 'FETCH_ALL_ITEMS'
export const FETCH_ALL_ITEMS_SUCCESS = 'FETCH_ALL_ITEMS_SUCCESS'
export const FETCH_ALL_ITEMS_ERROR = 'FETCH_ALL_ITEMS_ERROR'
export const LIKE = 'LIKE'
export const AUTH_START = 'AUTH_START'
export const AUTH_SUCCESS = 'AUTH_SUCCESS'
export const AUTH_FAIL = 'AUTH_FAIL'
export const AUTHOPEN = 'AUTHOPEN'
export const AUTHCLOSE = 'AUTHCLOSE'

// Action
export function like(index) {
  if (Auth.authorized) {
    $.post("/api/likes", {photo_id: index, token: Auth.getParams('token'), authenticity_token: Auth.getParams('authenticity_token')} );
  }
  return { type: LIKE, index }
}

export function authclose(index) {
  return { type: AUTHCLOSE, index }
}


export function auth(index, provider, dispatch) {
  Auth.run(index, provider).then(function(result) {
    console.log(result);
    dispatch({type: AUTH_SUCCESS});
    dispatch({type: AUTHCLOSE, index});
    // dispatch({type: LIKE, index});
    dispatch(like(index));
  }, function(err) {
    console.log(error);
  });
  return { type: AUTH_START, index, provider }
}

export function fetchAllItemsFromServer() {
  return function (dispatch) {
    dispatch({type: FETCH_ALL_ITEMS});
    return fetch('/api/photos.json')
      .then(response => response.json())
      .then(json => dispatch({type: FETCH_ALL_ITEMS_SUCCESS,photos: json.photos}))
      .catch(errors => dispatch({type: FETCH_ALL_ITEMS_ERROR, errors: errors}))
  };
}