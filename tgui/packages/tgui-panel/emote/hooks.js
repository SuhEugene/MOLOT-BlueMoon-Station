import { useDispatch, useSelector } from 'common/redux';
import { selectEmote} from './selectors';

export const useEmote = context => {
  const emote = useSelector(context, selectEmote);
  const dispatch = useDispatch(context);
  return {
    ...emote,
    toggle: () => dispatch({ type: 'emote/toggle' }),
  };
};
