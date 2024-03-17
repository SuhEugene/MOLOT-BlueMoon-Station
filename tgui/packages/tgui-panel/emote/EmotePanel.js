import { toFixed } from 'common/math';
import { useLocalState, useBackend } from 'tgui/backend';
import { useDispatch, useSelector } from 'common/redux';
import { Box, Button, ColorBox, Divider, Dropdown, Flex, Input, LabeledList, NumberInput, Section, Stack, Tabs, TextArea } from 'tgui/components';
import { ChatPageSettings } from '../chat';
import { rebuildChat, saveChatToDisk } from '../chat/actions';
import { THEMES } from '../themes';
import { selectEmote } from './selectors';
import { Window } from 'tgui/layouts';
import { sendMessage } from 'tgui/backend';

export const EmotePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const emote = useSelector(context, selectEmote);
  const dispatch = useDispatch(context);
  return (
    <Section>
      <Stack align="center">
        <Stack.Item grow={1}>
          <Input
            fluid
            /*value={page.name}*//>
        </Stack.Item>
        <Stack.Item>
          <Button
            icon="plus"
            color="green"
            /*onClick={(e, value) => {
              dispatch(addEmote({
              name: value,
            }))}} *//>
        </Stack.Item>
        <Stack.Item>
          <Button
            icon="times"
            color="red"
            /*onClick={() => dispatch(removeChatPage({
              pageId: page.id,
            }))}*/>
            Remove
          </Button>
        </Stack.Item>
      </Stack>
      <Divider />
      <Flex align="center">
        <Flex.Item ml={1}>
          <Button
            //icon="plus"
            color="green"
            content="*meow"
            /*onClick={() => act('emote', {
              key: "meow",
            })} />*/
            onClick={() => sendMessage({
              type: 'doEmote',
              payload: 'meow',
            })} />
        </Flex.Item>
      </Flex>
    </Section>
  );
};
