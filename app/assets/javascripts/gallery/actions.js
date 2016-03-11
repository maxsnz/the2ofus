import fetch from 'isomorphic-fetch';

export const FETCH_ALL_ITEMS = 'FETCH_ALL_ITEMS'
export const FETCH_ALL_ITEMS_SUCCESS = 'FETCH_ALL_ITEMS_SUCCESS'
export const FETCH_ALL_ITEMS_ERROR = 'FETCH_ALL_ITEMS_ERROR'
export const LIKE = 'LIKE'
export const AUTH = 'AUTH'

// Action
export function like(index) {
  return { type: LIKE, index }
}

export function auth(index, provider) {
  Auth.run(provider);
  return { type: AUTH, index, provider }
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