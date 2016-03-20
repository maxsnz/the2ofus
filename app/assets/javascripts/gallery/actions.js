import fetch from 'isomorphic-fetch';
import { formatArrayAsObject, getObjById, getIds } from './helpers'

export const FETCH_ALL_ITEMS = 'FETCH_ALL_ITEMS'
export const FETCH_ALL_ITEMS_SUCCESS = 'FETCH_ALL_ITEMS_SUCCESS'
export const FETCH_ALL_ITEMS_ERROR = 'FETCH_ALL_ITEMS_ERROR'
export const LIKE = 'LIKE'
export const AUTH_START = 'AUTH_START'
export const AUTH_SUCCESS = 'AUTH_SUCCESS'
export const AUTH_FAIL = 'AUTH_FAIL'
export const AUTHOPEN = 'AUTHOPEN'
export const AUTHCLOSE = 'AUTHCLOSE'
export const LIKES_RECEIVED = 'LIKES_RECEIVED'
export const REQUEST_PHOTO = 'REQUEST_PHOTO'
export const RECEIVE_PHOTO = 'RECEIVE_PHOTO'
export const OPEN_PHOTO = 'OPEN_PHOTO'
export const CLOSE_PHOTO = 'CLOSE_PHOTO'

// Action
export function like(id) {
  if (Auth.authorized) {
    $.post("/api/likes", {photo_id: id, token: Auth.getParams('token'), authenticity_token: Auth.getParams('authenticity_token')} );
    return { type: LIKE, id }
  } else {
    return { type: AUTHOPEN, id }
    
  }
  
}



function requestPhoto(id) {
  return {
    type: REQUEST_PHOTO,
    id
  };
}


function receivePhoto(id, json) {
  return {
    type: RECEIVE_PHOTO,
    id,
    photo: json
  };
}

function openPhoto(id) {
  // console.log($('#item_'+id).offset().top);
  // if (($('body.mobile .p').length > 0) && ($('#item_'+id).length > 0)) {

  //   $('body.mobile .p').css('top', $('#item_'+id).offset().top+'px');
  // }
  return {
    type: OPEN_PHOTO,
    id
  };
}

export function closePhoto(id) {
  window.history.pushState({},"", '/gallery');
  return {
    type: CLOSE_PHOTO
  };
}



function shouldFetchPhoto(state, id) {
  const photo = state.gallery.photos[id];
  if ((photo.rating) || (photo.isFetching)) {
    return false;
  } else  {
    return true;
  }
}

function fetchPhoto(id) {
  return dispatch => {
    dispatch(requestPhoto(id));
    return fetch('/api/photos/'+id)
      .then(response => response.json())
      .then(json => dispatch(receivePhoto(id, json)));
  };
}

export function nextPageClicked(page) {
  return {
    type: NEXT_PAGE_CLICKED,
    page
  };
}


export function photoClicked(id) {
  // console.log('photoClicked', id);
  window.history.pushState({},"", '/gallery/'+id);
  return (dispatch, getState) => {
    if (shouldFetchPhoto(getState(), id)) {
      return dispatch(fetchPhoto(id)).then(() =>
        dispatch(openPhoto(id))
      );
    } else {
      return dispatch(openPhoto(id));
    }
  };
}


export function getMyLikes(dispatch) {
  // console.log('getMyLikes started!');
  $.get("/api/likes", {token: Auth.getParams('token'), authenticity_token: Auth.getParams('authenticity_token')}, function(data) {
    data = getIds(data, 'photo_id');
    dispatch({type: LIKES_RECEIVED, data});
  });
}

export function authclose(id) {
  return { type: AUTHCLOSE, id }
}


export function auth(id, provider, dispatch) {
  Auth.run(id, provider).then(function(result) {
    // console.log(result);
    dispatch({type: AUTH_SUCCESS});
    dispatch({type: AUTHCLOSE});
    // dispatch({type: LIKE, id});
    dispatch(like(id));
    getMyLikes(dispatch);
  }, function(err) {
    console.log(error);
  });
  return { type: AUTH_START, id, provider }
}

export function fetchAllItemsFromServer() {
  return function (dispatch) {
    dispatch({type: FETCH_ALL_ITEMS});
    return fetch('/api/photos.json')
      .then(response => response.json())
      .then(json => dispatch({type: FETCH_ALL_ITEMS_SUCCESS,photos: formatArrayAsObject(json.photos), total_pages: json.total_pages, current_page:json.current_page}))
      .then(response => {
        let photo = parseInt(window.location.pathname.split('/')[2])
        if (photo > 0) {
          dispatch(photoClicked(photo))
        }
      })
      .catch(errors => dispatch({type: FETCH_ALL_ITEMS_ERROR, errors: errors}))
  };
}