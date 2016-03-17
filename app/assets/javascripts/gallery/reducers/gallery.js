import { FETCH_ALL_ITEMS, FETCH_ALL_ITEMS_SUCCESS, FETCH_ALL_ITEMS_ERROR, LIKE, AUTHOPEN, AUTHCLOSE, AUTH_START, AUTH_SUCCESS,  AUTH_FAIL, LIKES_RECEIVED, REQUEST_PHOTO, RECEIVE_PHOTO, OPEN_PHOTO, CLOSE_PHOTO} from '../actions'

// Reducer for authorization store
export default function authorization(state = initialState, action) {
  console.log(action);
  switch (action.type) {

  default:
    return state;
  }
}

const initialState = {
  isLoading: false,
  authorized: false,
  openedPhoto: false,
  photos: []
  // photos: [{"id":1,"authOpened":false,"src":"http://cs628622.vk.me/v628622034/3900d/Qck_3pkNdH4.jpg","username":"Joanna Kuchta"},{"id":3,"src":"http://cs627526.vk.me/v627526119/40122/uqgkpwImNRY.jpg","username":"Dinochka Good-Natured"},{"id":4,"src":"http://cs631716.vk.me/v631716486/10b8a/lq0wIva24zQ.jpg","username":"Kylie Jenner"},{"id":9,"src":"http://cs628530.vk.me/v628530576/356b3/OCZmmkxDYAY.jpg","username":"CALVIN KLEIN JEANS"},{"id":16,"src":"http://cs633619.vk.me/v633619389/eca4/VcGTUwnc4n4.jpg","username":"Ангелина Васильевна"},{"id":17,"src":"http://cs630916.vk.me/v630916359/c534/aEoiy-vp0_M.jpg","username":"Себастьян Клеменс"}]
};

function likes(state, action) {
  switch (action.type) {
  case LIKES_RECEIVED:

    let newItems = {...state};
    action.data.forEach((likedId) => {
      if (newItems[likedId]) newItems[likedId].liked = true;
    });

    return newItems;
  default:
    return state;
  }
}

// Reducer for photo store
function photo(state, action) {
  switch (action.type) {
  case LIKE:
    return Object.assign({}, state, {
      liked: true
    });
  default:
    return state;
  }
}

// Reducer for gallery photos store
function photos(state, action) {
  switch (action.type) {

  case FETCH_ALL_ITEMS:
    return Object.assign({}, state, {
      isLoading: true
    })
  case FETCH_ALL_ITEMS_SUCCESS:
    return Object.assign({}, state, {
      isLoading: false,
      photos: action.photos
    })
  case FETCH_ALL_ITEMS_ERROR:
    return Object.assign({}, state, {
      isLoading: false,
      errors: action.errors
    })
  case LIKES_RECEIVED:
    return Object.assign({}, state, {
      photos: likes(state.photos, action)
    });
  case AUTHOPEN:
    return Object.assign({}, state, {
      authOpened: action.id
    });
  case AUTHCLOSE:
    return Object.assign({}, state, {
      authOpened: false
    });
  case LIKE:
    let id = action.id;
    return Object.assign({}, state, {
      [id]: Object.assign({}, state[id], {
        liked: true
      })
    });
  default:
    return state;
  }
}

// Reducer for gallery store
export default function gallery(state = initialState, action) {
  console.log(action);
  switch (action.type) {
  case AUTH_START:
    return Object.assign({}, state, {
      authorized: 'pending'
    });
  case AUTH_SUCCESS:
    return Object.assign({}, state, {
      authorized: true
    });
  case AUTH_FAIL:
    return Object.assign({}, state, {
      authorized: 'fail'
    });

  case AUTHOPEN:
  case AUTHCLOSE:
  case FETCH_ALL_ITEMS:
  case FETCH_ALL_ITEMS_SUCCESS:
  case FETCH_ALL_ITEMS_ERROR:
  case LIKES_RECEIVED:
    return photos(state, action);
  case LIKE:
    return Object.assign({}, state, {
      photos: photos(state.photos, action)
    });

  case REQUEST_PHOTO:
  case RECEIVE_PHOTO:
    return state;
  case OPEN_PHOTO:
    return Object.assign({}, state, {
      openedPhoto: action.id
    });
  case CLOSE_PHOTO:
    return Object.assign({}, state, {
      openedPhoto: false
    });
  default:
    return state;
  }
}
