import { FETCH_ALL_ITEMS, FETCH_ALL_ITEMS_SUCCESS, FETCH_ALL_ITEMS_ERROR, LIKE, AUTHOPEN, AUTHCLOSE, AUTH_START, AUTH_SUCCESS,  AUTH_FAIL} from '../actions'

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
  items: []
  // items: [{"id":1,"authOpened":false,"src":"http://cs628622.vk.me/v628622034/3900d/Qck_3pkNdH4.jpg","username":"Joanna Kuchta"},{"id":3,"src":"http://cs627526.vk.me/v627526119/40122/uqgkpwImNRY.jpg","username":"Dinochka Good-Natured"},{"id":4,"src":"http://cs631716.vk.me/v631716486/10b8a/lq0wIva24zQ.jpg","username":"Kylie Jenner"},{"id":9,"src":"http://cs628530.vk.me/v628530576/356b3/OCZmmkxDYAY.jpg","username":"CALVIN KLEIN JEANS"},{"id":16,"src":"http://cs633619.vk.me/v633619389/eca4/VcGTUwnc4n4.jpg","username":"Ангелина Васильевна"},{"id":17,"src":"http://cs630916.vk.me/v630916359/c534/aEoiy-vp0_M.jpg","username":"Себастьян Клеменс"}]
};

// Reducer for photo store
function photo(state, action) {
  switch (action.type) {
  case LIKE:
    if (state.id == action.index) {
      return Object.assign({}, state, {
        liked: true
      });
    }
  case AUTHOPEN:
    if (state.id !== action.index) {
      return Object.assign({}, state, {
        authOpened: false
      });
    } else {
      return Object.assign({}, state, {
        authOpened: true
      });
    }
  case AUTHCLOSE:
    return Object.assign({}, state, {
      authOpened: false
    });
  default:
    return state;
  }
}

// Reducer for photos items store
function photosItems(state, action) {
  switch (action.type) {
  case LIKE:
  case AUTHOPEN:
  case AUTHCLOSE:
    return state.map(item =>
      photo(item, action)
    )
  default:
    return state;
  }
}

// Reducer for photos store
export default function photos(state = initialState, action) {
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
  case FETCH_ALL_ITEMS:
    return Object.assign({}, state, {
      isLoading: true
    })
  case FETCH_ALL_ITEMS_SUCCESS:
    return Object.assign({}, state, {
      isLoading: false,
      items: action.photos
    })
  case FETCH_ALL_ITEMS_ERROR:
    return Object.assign({}, state, {
      isLoading: false,
      errors: action.errors
    })
  case LIKE:
    if (state.authorized != true) {
      action.type = AUTHOPEN;
    }
    return Object.assign({}, state, {
      items: photosItems(state.items, action)
    })
  case AUTHCLOSE:
    return Object.assign({}, state, {
      items: photosItems(state.items, action)
    })
  default:
    return state;
  }
}
