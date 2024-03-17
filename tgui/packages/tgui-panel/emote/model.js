import { createUuid } from 'common/uuid';

export const createEmoteButton = obj => ({
  id: createUuid(),
  name: 'New Emote',
  createdAt: Date.now(),
  ...obj,
});
