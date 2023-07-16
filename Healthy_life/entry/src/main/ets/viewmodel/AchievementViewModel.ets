/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { ACHIEVEMENT_LEVEL_LIST, AchievementMap,ACHIEVEMENT_LEVEL_LIST_SINGLE,AchievementMap_single } from '../model/TaskInitList';

export function getBadgeCardItems(successiveDays: number):[string, Resource][] {
  let badgeMileStones = ACHIEVEMENT_LEVEL_LIST;
  let cardItems:[string, Resource][] = [];
  for (let i = 0; i < badgeMileStones.length; i++) {
    let onOrOff = successiveDays >= badgeMileStones[i] ? 'on' : 'off';
    let titleContent = String(badgeMileStones[i]);
    let oneItem:[string, Resource] = [titleContent,AchievementMap[`${ badgeMileStones[i] }_${ onOrOff }`]];
    cardItems.push(oneItem);
  }
  return cardItems;
}

//新增单项成就
export function getBadgeCardItems_single(successiveTimes: number):[string, Resource][] {
  let badgeMileStones = ACHIEVEMENT_LEVEL_LIST_SINGLE;
  let cardItems:[string, Resource][] = [];
  for (let i = 0; i < badgeMileStones.length; i++) {
    let onOrOff = successiveTimes >= badgeMileStones[i] ? 'on' : 'off';
    let titleContent = String(badgeMileStones[i]);
    let oneItem:[string, Resource] = [titleContent,AchievementMap_single[`${ badgeMileStones[i] }_${ onOrOff }`]];
    cardItems.push(oneItem);
  }
  return cardItems;
}