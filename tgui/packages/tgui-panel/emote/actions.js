import { createAction } from 'common/redux';
import { createEmoteButton } from './model';

export const addEmote = createAction('emote/addEmote', () => ({
  payload: createEmoteButton(),
}));
