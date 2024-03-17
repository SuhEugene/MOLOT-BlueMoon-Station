const initialState = {
  visible: false,
};

export const emoteReducer = (state = initialState, action) => {
  const { type, payload } = action;
  if (type === 'emote/toggle') {
    return {
      ...state,
      visible: !state.visible,
    };
  }
  /*if (type === addEmote.type) {
    return {
      ...state,
      currentButtonId: payload.id,
      pages: [...state.pages, payload.id],
      pageById: {
        ...state.pageById,
        [payload.id]: payload,
      },
    };
  }*/
  return state;
};
